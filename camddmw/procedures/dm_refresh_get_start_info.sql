create or replace procedure camddmw.dm_refresh_get_start_info
(
    out is_full_refresh     boolean,
    out lookback_date       date
)
as
$$
begin
    
    -- Get Lookback Date, if one exists.
    select  max( drl.started_time )
      into  lookback_date
      from  camddmw.DM_REFRESH_LOG drl
     where  drl.completed_time is not null;
    
    -- Deteremine whether a Full Refresh should occur.
    select  case
                -- Full Refresh if no Refresh and therefor no Full Refresh has completed.
                when ( lookback_date is null )
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
                           --and  par.system_parameter_value is not null
                           and  camdaux.cast_date_or_null( par.system_parameter_value ) <= current_date
                     )
                then true
                else false
            end
      into  is_full_refresh;
    
    -- Ensure that Lookback Date is null for a Full Refresh.
    if is_full_refresh
    then
        lookback_date = null;
    end if;
  
exception when others then
    is_full_refresh = null;
    lookback_date = null;
end;
$$
language plpgsql;