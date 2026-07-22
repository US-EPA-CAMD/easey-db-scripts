create or replace procedure camdsnap.REFRESH_MATERIALIZED_VIEWS()
language plpgsql
as
$$
begin
    
    -------------------------------------
    -- No Materialized View Dependency --
    -------------------------------------

    -- refresh materialized view camdsnap.ACCOUNT_BLOCK_SS;
    -- refresh materialized view camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS;
    -- refresh materialized view camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS;
    -- refresh materialized view camdsnap.ACCOUNT_COMPLIANCE_PENALTY;
    -- refresh materialized view camdsnap.ACCOUNT_COMPLIANCE_SS;
    -- refresh materialized view camdsnap.ACCOUNT_FACILITY_SS;
    -- refresh materialized view camdsnap.ACCOUNT_OWNER_SS;
    -- refresh materialized view camdsnap.ACCOUNT_PEOPLE_SS;
    -- refresh materialized view camdsnap.ACCOUNT_PROGRAM_SS;
    -- refresh materialized view camdsnap.ACCOUNT_SS;
    -- refresh materialized view camdsnap.AGENCY_SS;
    -- refresh materialized view camdsnap.ALLOWANCE_BLOCK_SS;
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
    -- refresh materialized view camdsnap.UNIT_HISTORY_SS;
    refresh materialized view camdsnap.UNIT_MONITOR_SS;
    refresh materialized view camdsnap.UNIT_OP_STATUS_SS;
    refresh materialized view camdsnap.UNIT_PROGRAM_EXEMPTION_SS;

    ----------------------------------------------
    -- First Level Materialized View Dependency --
    ----------------------------------------------
    
    -- refresh materialized view camdsnap.UNIT_PEOPLE_SS;
    
end;
$$;