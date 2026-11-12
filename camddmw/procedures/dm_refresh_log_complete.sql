create or replace procedure camddmw.dm_refresh_log_complete
(
    in  dmRefreshLogId_in   int,
    out errorJson_out       json,
    out result_out          boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_log_complete';
    
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
    
    -- Clear the incremental refresh date if it is before todays date.
    update  camdaux.SYSTEM_PARAMETER
       set  system_parameter_value = null
     where  system_parameter_name = 'DM_REFRESH_FORCE_FULL_REFRESH_DATE'
       and  camdaux.cast_date_or_null( system_parameter_value ) <= current_date;
    
    
    -- Update DM_REFRESH_LOG.
    update  camddmw.DM_REFRESH_LOG
       set  completed_time = now(),
            note_time = null,
            note_json = null
     where  dm_refresh_log_id = dmRefreshLogId_in;

    
    -- Return Value
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