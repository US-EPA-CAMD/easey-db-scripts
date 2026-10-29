create or replace procedure camddmw.dm_refresh_unit_fact_stacks_pipes_update
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_fact_stacks_pipes_update';

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
    
    update  camddmw.UNIT_FACT unf
       set  assoc_stacks =
            (
                select  string_agg( distinct sub_loc.location_id, ', ' order by sub_loc.location_id ) as assoc_units
                  from  camdsnap.UNIT_MONITOR_SS sub_unm
                        join camdsnap.MONITOR_LOCATION_SS sub_loc using ( mon_loc_id )
                 where  sub_unm.unit_id = unf.unit_id
                   and  sub_loc.stack_pipe_id is not null
                   and  ( ( sub_loc.active_date is null ) or ( extract( year from sub_loc.active_date ) <= unf.op_year ) )
                   and  ( ( sub_loc.retire_date is null ) or ( extract( year from sub_loc.retire_date ) >= unf.op_year ) )
                 group
                    by  sub_unm.unit_id
            )
     where  ( fullRefresh_in or ( unf.add_date >= increamentalRefreshDate_in ) );
    
    
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