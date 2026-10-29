create or replace procedure camddmw.dm_refresh_clear_tables
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_clear_tables';

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
    
    if fullRefresh_in then
        
        ------------------
        -- Full Refresh --
        ------------------
        
        truncate table camddmw.ACCOUNT_FACT cascade;
        truncate table camddmw.ACCOUNT_OWNER_DIM cascade;
        truncate table camddmw.ACCOUNT_REP_DIM cascade;
        truncate table camddmw.ALLOWANCE_HOLDING_REP_DIM cascade;
        truncate table camddmw.BANK_DIM cascade;
        truncate table camddmw.MONITOR_FACT cascade;
        truncate table camddmw.STATE_ALLOCATION_FACT cascade;
        truncate table camddmw.TRANSACTION_FACT cascade;
        truncate table camddmw.UNIT_FACT cascade;
        
    elsif ( increamentalRefreshDate_in is not null ) then
        
        --------------------------
        -- Increamental Refresh --
        --------------------------
        
        delete
          from  camddmw.UNIT_FACT unf
         where  exists
                (
                    -- UNIT_SS
                    select  1
                      from  camdsnap.UNIT_SS exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            /* TODO: Uncomment when the UNIT_PEOPLE_SS MV can and has been created.
            or  exists
                (
                    -- UNIT_PEOPLE_SS
                    select  1
                      from  camdsnap.UNIT_PEOPLE_SS exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            */
            or  exists
                (
                    -- UNIT_PROGRAM_SS
                    select  1
                      from  camdsnap.UNIT_PROGRAM_SS exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- UNIT_OP_STATUS_SS
                    select  1
                      from  camdsnap.UNIT_OP_STATUS_SS exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- UNIT_PROGRAM_EXEMPTION_SS
                    select  1
                      from  camdsnap.UNIT_PROGRAM_SS unp
                            join camdsnap.UNIT_PROGRAM_EXEMPTION_SS exs using ( up_id )
                     where  unp.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- FACILITY_SS
                    select  1
                      from  camdsnap.UNIT_SS unt
                            join camdsnap.FACILITY_SS exs using ( fac_id )
                     where  unt.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- MONITOR_PLAN_REPORTING_FREQ_SS
                    select  1
                      from  camdsnap.MONITOR_LOCATION_SS mpl
                            join camdsnap.MONITOR_PLAN_LOCATION_SS mpl using ( mon_loc_id )
                            join camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS exs using ( mon_plan_id )
                     where  mpl.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- PROGRAM_SS
                    select  1
                      from  camdsnap.UNIT_PROGRAM_SS  unp
                            join camdsnap.PROGRAM_SS exs using ( prg_id )
                     where  unp.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- ANNUAL_UNIT_DATA
                    select  1
                      from  camddmw.ANNUAL_UNIT_DATA exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                )
            or  exists
                (
                    -- ANNUAL_UNIT_DATA
                    select  1
                      from  camddmw_arch.ANNUAL_UNIT_DATA_A exs
                     where  exs.unit_id = unf.unit_id
                       and  ( exs.add_date::date >= increamentalRefreshDate_in or exs.update_date::date >= increamentalRefreshDate_in )
                );
        
    else
        
        raise exception 'Increamental Refreshes require a value for the increamentalRefreshDate_in parameter.';
        
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
end;
$$
language plpgsql;