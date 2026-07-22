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
    refresh materialized view camdsnap.PROGRAM_SS;
    refresh materialized view camdsnap.PROGRAM_PHASE_SS;
    refresh materialized view camdsnap.UNIT_BT_TYPE_SS;
    refresh materialized view camdsnap.UNIT_CAPACITY_SS;
    refresh materialized view camdsnap.UNIT_CONTROL_SS;
    refresh materialized view camdsnap.UNIT_FUEL_SS;
    refresh materialized view camdsnap.UNIT_MONITOR_SS;
    refresh materialized view camdsnap.UNIT_OP_STATUS_SS;
    
end;
$$;