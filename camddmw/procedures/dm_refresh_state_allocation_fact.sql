create or replace procedure camddmw.dm_refresh_state_allocation_fact
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_state_allocation_fact';

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
    
    truncate table camddmw.STATE_ALLOCATION_FACT;
    
    insert
      into  camddmw.STATE_ALLOCATION_FACT
            ( vintage_year, state, state_name, pr_cap, pr_issue, optin_cap, optin_issue, er_cap, er_issue, total_cap, total_issue )
    select  tay.allwyear_dt as vintage_year,
            substr( tay.acctnum_id, 1, 2 ) as state,
            stc.state_name,
            sum( case ( acc.accttype_cd ) when 'EA' then  tay.yearmax_tot end ) as pr_cap,
            sum( case ( acc.accttype_cd ) when 'EA' then  tay.yearissu_tot end ) as pr_issue,
            sum( case ( acc.accttype_cd ) when 'OI' then  tay.yearmax_tot end ) as optin_cap,
            sum( case ( acc.accttype_cd ) when 'OI' then  tay.yearissu_tot end ) as optin_issue,
            sum( case ( acc.accttype_cd ) when 'ER' then  tay.yearmax_tot end ) as er_cap,
            sum( case ( acc.accttype_cd ) when 'ER' then  tay.yearissu_tot end ) as er_issue,
            sum( tay.yearmax_tot ) as total_cap,
            sum( tay.yearissu_tot ) as total_issue
      from  camdnats.TAUTHYR tay
            join camdnats.TACCOUNT acc on acc.acctnum_id = tay.acctnum_id
            join camdmd.STATE_CODE stc on stc.state_cd = substr( tay.acctnum_id, 1, 2 )
     where  acc.accttype_cd in ( 'EA', 'ER', 'OI' )
     group
        by  tay.allwyear_dt,
            substr( tay.acctnum_id, 1, 2 ),
            stc.state_name;
    
    
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