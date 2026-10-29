create or replace procedure camddmw.dm_refresh_fuel_year_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_fuel_year_dim';

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
      into  camddmw.FUEL_YEAR_DIM
            ( op_year, unit_id, fuel_code, fuel_type_description, indicator, data_source, userid, add_date, last_update_date )
    select  oyr.op_year,
            ufs.unit_id,
            ufs.fuel_type as fuel_code,
            ftc.fuel_type_description,
            ufs.indicator_cd as indicator,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            max( now() ) as add_date,
            max( greatest( ufs.add_date, ufs.update_date, unt.add_date, unt.update_date ) ) as last_update_date
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
            join camdsnap.UNIT_FUEL_SS ufs
              on case
                    when ( ufs.begin_date is not null )
                    then ( extract( year from ufs.begin_date ) <= oyr.op_year )
                    else true -- Later checking will determine whether the op_year applies to the UNIT_FUEL_SS row.
                 end
             and ( ( ufs.end_date is null ) or ( extract( year from ufs.end_date ) >= oyr.op_year ) )
             and ufs.indicator_cd in ( 'P', 'S' )
            join camdsnap.UNIT_SS unt
              on unt.unit_id = ufs.unit_id
             and case
                    when ( ufs.begin_date is not null )
                    then true -- Earlier checking determined whether the op_year applies to the UNIT_FUEL_SS row.
                    when ( coalesce( unt.comm_op_date, unt.comr_op_date, unt.add_date ) is not null )
                    then ( extract( year from coalesce( unt.comm_op_date, unt.comr_op_date, unt.add_date ) ) <= oyr.op_year )
                    else true
                 end
            join camddmw.UNIT_FACT unf 
              on unf.op_year = oyr.op_year
             and unf.unit_id = unt.unit_id
            join camdecmpsmd.FUEL_TYPE_CODE ftc 
              on ftc.fuel_type_cd = ufs.fuel_type
     where  ( fullRefresh_in or ( greatest( ufs.add_date, ufs.update_date, unf.add_date ) >= increamentalRefreshDate_in ) )
     group
        by  oyr.op_year,
            ufs.unit_id,
            ufs.fuel_type,
            ftc.fuel_type_description,
            ufs.indicator_cd
        on  conflict( op_year, unit_id, fuel_code, indicator )
        do  update
               set  fuel_type_description   = excluded.fuel_type_description,
                    data_source             = excluded.data_source,
                    userid                  = excluded.userid,
                    add_date                = excluded.add_date,
                    last_update_date        = excluded.last_update_date
             where  (
                        ( coalesce( excluded.fuel_type_description, '' ) != coalesce( fuel_year_dim.fuel_type_description, '' ) )
                        or
                        ( excluded.last_update_date != fuel_year_dim.last_update_date )
                    );
    
    
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