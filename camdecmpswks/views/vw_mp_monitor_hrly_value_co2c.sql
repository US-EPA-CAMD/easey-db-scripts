-- View: camdecmpswks.vw_mp_monitor_hrly_value_co2c

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_co2c;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_co2c
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'CO2C'::text;
