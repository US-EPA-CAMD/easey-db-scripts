create or replace procedure camddmw.dm_refresh_bank_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_bank_dim';

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
    
    truncate table camddmw.BANK_DIM;
    
    insert
      into  camddmw.BANK_DIM
            ( account_number, prg_code, calendar_year, count_of_sold, total_allowance_sold, count_of_received, total_allowance_received, data_source, userid, add_date )
    select  cmb.account_number,
            cmb.prg_code,
            cmb.calendar_year,
            sum( cmb.count_of_sold ) as count_of_sold,
            sum( cmb.total_allowance_sold ) as total_allowance_sold,
            sum( cmb.count_of_received  ) as count_of_received ,
            sum( cmb.total_allowance_received ) as total_allowance_received,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                select  trf.sell_acct_number as account_number,
                        trf.prg_code,
                        extract( year from trf.transaction_date ) as calendar_year,
                        count( 1 ) as count_of_sold,
                        sum( trf.transaction_total ) as total_allowance_sold,
                        null as count_of_received,
                        null as total_allowance_received
                  from  camddmw.TRANSACTION_FACT trf
                 group
                    by  trf.sell_acct_number,
                        trf.prg_code,
                        extract( year from trf.transaction_date )
                union   all
                select  trf.buy_acct_number as account_number,
                        trf.prg_code,
                        extract( year from trf.transaction_date ) as calendar_year,
                        null as count_of_sold,
                        null as total_allowance_sold,
                        count( 1 ) as count_of_received,
                        sum( trf.transaction_total ) as total_allowance_received
                  from  camddmw.TRANSACTION_FACT trf
                 group
                    by  trf.buy_acct_number,
                        trf.prg_code,
                        extract( year from trf.transaction_date )
            ) cmb
     group
        by  cmb.account_number,
            cmb.prg_code,
            cmb.calendar_year;
    
    
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