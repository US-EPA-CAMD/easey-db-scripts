create or replace procedure camddmw.dm_refresh_unit_type_year_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_type_year_dim';

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
      into  camddmw.UNIT_TYPE_YEAR_DIM
            ( op_year, unit_id, unit_type, unit_type_description, data_source, userid, add_date, last_update_date )
    select  oyr.op_year,
            ubt.unit_id,
            ubt.unit_type,
            utc.unit_type_description,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            now() as add_date,
            greatest( ubt.add_date, ubt.update_date, unt.add_date, unt.update_date ) as last_update_date
      from  (
                select  op_year,
                        op_year_min
                  from  (
                            select  min( unf.op_year ) as op_year_min,
                                    max( unf.op_year ) as op_year_max
                              from  camddmw.UNIT_FACT unf
                        ) rng,
                        generate_series( rng.op_year_min, rng.op_year_max ) as op_year
            ) oyr
            join camdsnap.UNIT_BT_TYPE_SS ubt
              on ( ( ubt.begin_date is null ) or ( extract( year from ubt.begin_date ) <= oyr.op_year ) )
             and ( ( ubt.end_date is null ) or ( extract( year from ubt.end_date ) >= oyr.op_year ) )
            join camdsnap.UNIT_SS unt
              on unt.unit_id = ubt.unit_id
             and case
                    when ( ubt.begin_date is not null )
                    then true -- Check done in UNIT_BT_TYPE_SS join and checking Commence and Commercial dates is not needed.
                    when ( unt.comm_op_date is not null )
                    then extract( year from unt.comm_op_date ) <= oyr.op_year
                    when ( unt.comr_op_date is not null )
                    then extract( year from unt.comr_op_date ) <= oyr.op_year
                    else oyr.op_year_min <= oyr.op_year
                 end
            join camdmd.UNIT_TYPE_CODE utc
              on utc.unit_type_cd = ubt.unit_type
     where  exists
            (
                select  1
                  from  camddmw.UNIT_FACT exs
                 where  exs.op_year = oyr.op_year
                   and  exs.unit_id = ubt.unit_id
            )
       and  ( fullRefresh_in or ( greatest( ubt.add_date, ubt.update_date, unt.add_date, unt.update_date ) >= increamentalRefreshDate_in ) )
        on  conflict( op_year, unit_id, unit_type )
        do  update
               set  unit_type_description   = excluded.unit_type_description,
                    data_source             = excluded.data_source,
                    userid                  = excluded.userid,
                    add_date                = excluded.add_date,
                    last_update_date        = excluded.last_update_date
             where  ( ( coalesce( excluded.unit_type_description, '' ) != coalesce( unit_type_year_dim.unit_type_description, '' ) ) or ( excluded.last_update_date != unit_type_year_dim.last_update_date ) );
    
    
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