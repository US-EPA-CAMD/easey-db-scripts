CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_noxc (monitor_hrly_val_id, mon_plan_id, mon_loc_id, hour_id, rpt_period_id, calendar_year, quarter, mon_sys_id, component_id, parameter_cd, modc_cd, adjusted_hrly_value, unadjusted_hrly_value, pct_available, moisture_basis, begin_date, begin_hour, system_identifier, sys_type_cd, sys_designation_cd, component_type_cd, component_identifier, serial_number, acq_cd) AS
SELECT
    *
    FROM camdecmpswks.vw_mp_monitor_hrly_value
    WHERE (parameter_cd = 'NOXC');