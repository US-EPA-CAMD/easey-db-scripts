create or replace procedure camddmw.dm_refresh_owner_year_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_owner_year_dim';

    -- Stacked Diagnostic Variables
    vErrorReturnedSqlstate      text;
    vErrorMessageText           text;
    vErrorPgExceptionDetail     text;
    vErrorPgExceptionHint       text;
    vErrorPgExceptionContext    text;
    vErrorSchemaName            text;
    vErrorTableName             text;
    vErrorColumnName            text;
    vErrorConstraintName        text;
begin
    
    ------------------
    -- Refresh Data --
    ------------------
    
    insert
      into  camddmw.OWNER_YEAR_DIM
            ( 
                unit_id, op_year, own_id, own_type, own_display,
                data_source, userid, add_date, last_update_date
            )
    select  own.unit_id,
            vyr.valid_year as op_year,
            own.own_id,
            own.ont_type_cd as own_type,
            cmp.comp_name as own_display,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            now() as add_date,
            max( greatest( own.add_date, own.update_date, cmp.add_date, cmp.update_date, unf.last_update_date ) ) as last_update_date
      from  camddmw.ALLOWANCE_VALID_YEAR vyr
            join camdsnap.UNIT_OWNER_SS own
              on extract( year from own.begin_date ) <= vyr.valid_year
             and ( ( own.end_date is null ) or ( extract( year from own.end_date ) >= vyr.valid_year ) )
            join camddmw.UNIT_FACT unf
              on unf.op_year = vyr.valid_year
             and unf.unit_id = own.unit_id
            join camdsnap.COMPANY_SS cmp
              on cmp.comp_id = own.own_id
     where  (
                fullRefresh_in
                or
                own.add_date >= increamentalRefreshDate_in
                or
                own.update_date >= increamentalRefreshDate_in
                or
                cmp.add_date >= increamentalRefreshDate_in
                or
                cmp.update_date >= increamentalRefreshDate_in
                or
                unf.add_date >= increamentalRefreshDate_in
            )
     group
        by  -- Eliminates duplicate records created by multiple records for the same unit, owner, and owner type within the same year.
            -- The duplicates can exist because of interrupted ownership within a year.
            own.unit_id,
            vyr.valid_year,
            own.own_id,
            own.ont_type_cd,
            cmp.comp_name
        on  conflict ( unit_id, op_year, own_id, own_type )
        do  update
               set  own_display         = excluded.own_display,
                    data_source         = excluded.data_source,
                    userid              = excluded.userid,
                    add_date            = excluded.add_date,
                    last_update_date    = excluded.last_update_date;
    
    
    -- Return Values
    errorJson_out := null;
    result_out := true;
    
exception when others then
    get stacked diagnostics 
        vErrorReturnedSqlstate      = RETURNED_SQLSTATE,
        vErrorMessageText           = MESSAGE_TEXT,
        vErrorPgExceptionDetail     = PG_EXCEPTION_DETAIL,
        vErrorPgExceptionHint       = PG_EXCEPTION_HINT,
        vErrorPgExceptionContext    = PG_EXCEPTION_CONTEXT,
        vErrorSchemaName            = SCHEMA_NAME,
        vErrorTableName             = TABLE_NAME,
        vErrorColumnName            = COLUMN_NAME,
        vErrorConstraintName        = CONSTRAINT_NAME;
    
    errorJson_out := jsonb_build_object
                     (
                        'routine_name',             cProcedureName,
                        'returned_sqlstate',        vErrorReturnedSqlstate,
                        'message_text',             vErrorMessageText,
                        'pg_exception_detail',      vErrorPgExceptionDetail,
                        'pg_exception_hint',        vErrorPgExceptionHint,
                        'pg_exception_context',     vErrorPgExceptionContext,
                        'schema_name',              vErrorSchemaName,
                        'table_name',               vErrorTableName,
                        'column_name',              vErrorColumnName,
                        'constraint_name',          vErrorConstraintName
                     );
    
    result_out := false;
end;
$$
language plpgsql;
