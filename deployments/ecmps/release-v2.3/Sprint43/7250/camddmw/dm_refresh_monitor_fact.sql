create or replace procedure camddmw.dm_refresh_monitor_fact
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_monitor_fact';

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
        
        truncate table camddmw.MONITOR_FACT cascade;
        
    elsif ( increamentalRefreshDate_in is not null ) then
        
        --------------------------
        -- Increamental Refresh --
        --------------------------
        
        delete
          from  camddmw.MONITOR_FACT mfc
         where  exists
                (
                    select  1
                      from  camdsnap.MONITOR_LOCATION_SS exs
                     where  exs.mon_loc_id = mfc.mon_loc_id 
                );

        
    else
        
        raise exception 'Increamental Refreshes require a value for the increamentalRefreshDate_in parameter.';
        
    end if;
    
    
    ------------------
    -- Refresh Data --
    ------------------
    
    insert
      into  camddmw.MONITOR_FACT
            ( op_year, mon_loc_id, fac_id, location_id, assoc_units, add_date )
    select  vyr.valid_year as op_year,
            loc.mon_loc_id,
            loc.fac_id,
            loc.location_id,
            asu.assoc_units,
            now() as add_date
      from  (
                select  vyr.valid_year
                  from  camddmw.VALID_YEAR vyr
                 group
                    by  vyr.valid_year
            ) vyr
            join camdsnap.MONITOR_LOCATION_SS loc
              on loc.stack_pipe_id is not null
             and ( ( loc.active_date is null ) or ( extract( year from loc.active_date ) <= vyr.valid_year ) )
             and ( ( loc.retire_date is null ) or ( extract( year from loc.retire_date ) >= vyr.valid_year ) )
             and ( fullRefresh_in or ( loc.add_date >= increamentalRefreshDate_in ) )
            join lateral 
            (
                select  sub_unm.mon_loc_id,
                        string_agg( distinct sub_unt.unitid, ', ' order by sub_unt.unitid ) as assoc_units
                  from  camdsnap.UNIT_MONITOR_SS sub_unm
                        join camdsnap.MONITOR_LOCATION_SS sub_loc using ( unit_id )
                        join camdsnap.UNIT_SS sub_unt using ( unit_id ) -- Ensures that unit exists in UNIT_SS.
                 where  sub_unm.mon_loc_id = loc.mon_loc_id 
                   and  ( ( sub_loc.active_date is null ) or ( extract( year from sub_loc.active_date ) <= vyr.valid_year ) )
                   and  ( ( sub_loc.retire_date is null ) or ( extract( year from sub_loc.retire_date ) >= vyr.valid_year ) )
                 group
                    by  sub_unm.mon_loc_id
            ) asu
              on asu.mon_loc_id = loc.mon_loc_id;
    
    
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