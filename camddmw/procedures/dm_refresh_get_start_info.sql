create or replace procedure camddmw.dm_refresh_get_start_info
(
    out isFullRefresh_out   boolean,
    out lookbackDate_out    date,
    out errorJson_out       json,
    out result_out          boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_get_start_info';

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
    
    -- Get Lookback Date, if one exists.
    select  max( drl.started_time )
      into  lookbackDate_out
      from  camddmw.DM_REFRESH_LOG drl
     where  drl.completed_time is not null;
    
    -- Deteremine whether a Full Refresh should occur.
    select  case
                -- Full Refresh if no Refresh and therefor no Full Refresh has completed.
                when ( lookbackDate_out is null )
                then true
                -- Full Refresh on January 1st.
                when ( extract( month from current_date ) = 1 ) and ( extract( day from current_date ) = 1 )
                then true
                -- Full Refresh on 3rd Saturday of each month.
                when ( extract( dow from current_date ) = 6 ) and ( extract( day from current_date ) between 15 and 21 )
                then true
                -- Full Refresh when triggered by System Parameter DM_REFRESH_FORCE_FULL_REFRESH_DATE.
                when exists
                     (
                        select  1
                          from  camdaux.SYSTEM_PARAMETER par
                         where  par.system_parameter_name = 'DM_REFRESH_FORCE_FULL_REFRESH_DATE'
                           and  camdaux.cast_date_or_null( par.system_parameter_value ) <= current_date
                     )
                then true
                else false
            end
      into  isFullRefresh_out;
    
    -- Ensure that Lookback Date is null for a Full Refresh.
    if isFullRefresh_out
    then
        lookbackDate_out = null;
    end if;
    
    
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
    isFullRefresh_out = null;
    lookbackDate_out = null;
end;
$$
language plpgsql;