CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value (monitor_hrly_val_id, mon_plan_id, mon_loc_id, hour_id, rpt_period_id, calendar_year, quarter, mon_sys_id, component_id, parameter_cd, modc_cd, adjusted_hrly_value, unadjusted_hrly_value, pct_available, moisture_basis, begin_date, begin_hour, system_identifier, sys_type_cd, sys_designation_cd, component_type_cd, component_identifier, serial_number, acq_cd) AS
SELECT
    monitor_hrly_value.monitor_hrly_val_id, vw_mp_hrly_op_data.mon_plan_id, vw_mp_hrly_op_data.mon_loc_id, vw_mp_hrly_op_data.hour_id, vw_mp_hrly_op_data.rpt_period_id, vw_mp_hrly_op_data.calendar_year, vw_mp_hrly_op_data.quarter, monitor_hrly_value.mon_sys_id, monitor_hrly_value.component_id, monitor_hrly_value.parameter_cd, monitor_hrly_value.modc_cd, monitor_hrly_value.adjusted_hrly_value, monitor_hrly_value.unadjusted_hrly_value, monitor_hrly_value.pct_available, monitor_hrly_value.moisture_basis, vw_mp_hrly_op_data.begin_date, vw_mp_hrly_op_data.begin_hour, monitor_system.system_identifier, monitor_system.sys_type_cd, monitor_system.sys_designation_cd, component.component_type_cd, component.component_identifier, component.serial_number, component.acq_cd
    FROM camdecmpswks.monitor_hrly_value
    INNER JOIN camdecmpswks.vw_mp_hrly_op_data
        ON monitor_hrly_value.hour_id = vw_mp_hrly_op_data.hour_id
    LEFT OUTER JOIN camdecmpswks.component
        ON monitor_hrly_value.component_id = component.component_id
    LEFT OUTER JOIN camdecmpswks.monitor_system
        ON monitor_hrly_value.mon_sys_id = monitor_system.mon_sys_id
    WHERE COALESCE(monitor_hrly_value.modc_cd, '') NOT IN ('47', '48');