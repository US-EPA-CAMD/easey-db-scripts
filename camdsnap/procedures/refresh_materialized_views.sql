create or replace procedure camdsnap.REFRESH_MATERIALIZED_VIEWS()
language plpgsql
as
$$
begin
    
    refresh materialized view camdsnap.FACILITY_SS;
    refresh materialized view camdsnap.FACILITY_PEOPLE_SS;
    refresh materialized view camdsnap.MONITOR_LOCATION_SS;
    refresh materialized view camdsnap.MONITOR_PLAN_LOCATION_SS;
    refresh materialized view camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS;
    
end;
$$;