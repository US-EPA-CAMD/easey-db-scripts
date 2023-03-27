-- View: camdecmpswks.vw_mp_derived_hrly_value

DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value
 AS
 SELECT derived_hrly_value.derv_id,
    vw_mp_hrly_op_data.mon_plan_id,
    vw_mp_hrly_op_data.mon_loc_id,
    vw_mp_hrly_op_data.hour_id,
    vw_mp_hrly_op_data.rpt_period_id,
    vw_mp_hrly_op_data.calendar_year,
    vw_mp_hrly_op_data.quarter,
    vw_mp_hrly_op_data.begin_date,
    vw_mp_hrly_op_data.begin_hour,
    derived_hrly_value.parameter_cd,
    derived_hrly_value.unadjusted_hrly_value,
    derived_hrly_value.adjusted_hrly_value,
    derived_hrly_value.modc_cd,
    derived_hrly_value.mon_sys_id,
    derived_hrly_value.mon_form_id,
    derived_hrly_value.pct_available,
    derived_hrly_value.diluent_cap_ind,
    derived_hrly_value.operating_condition_cd,
    derived_hrly_value.segment_num,
    derived_hrly_value.fuel_cd,
    monitor_system.system_identifier,
    monitor_system.sys_type_cd,
    monitor_system.sys_designation_cd,
    monitor_formula.formula_identifier,
    monitor_formula.parameter_cd AS formula_parameter_cd,
    monitor_formula.equation_cd
   FROM camdecmpswks.derived_hrly_value
     JOIN camdecmpswks.vw_mp_hrly_op_data ON derived_hrly_value.hour_id::text = vw_mp_hrly_op_data.hour_id::text
     LEFT JOIN camdecmpswks.monitor_system ON derived_hrly_value.mon_sys_id::text = monitor_system.mon_sys_id::text
     LEFT JOIN camdecmpswks.monitor_formula ON derived_hrly_value.mon_form_id::text = monitor_formula.mon_form_id::text;
