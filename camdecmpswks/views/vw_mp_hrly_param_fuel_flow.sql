-- View: camdecmpswks.vw_mp_hrly_param_fuel_flow

DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_param_fuel_flow;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_param_fuel_flow
 AS
 SELECT hpff.hrly_param_ff_id,
    hff.hrly_fuel_flow_id,
    vwhod.hour_id,
    vwhod.mon_plan_id,
    vwhod.mon_loc_id,
    vwhod.rpt_period_id,
    vwhod.calendar_year,
    vwhod.quarter,
    vwhod.begin_date,
    vwhod.begin_hour,
    ms.mon_sys_id,
    hpff.mon_form_id,
    hpff.parameter_cd,
    hpff.param_val_fuel,
    hpff.calc_param_val_fuel,
    hpff.sample_type_cd,
    hpff.operating_condition_cd,
    hpff.segment_num,
    hpff.parameter_uom_cd,
    fc.fuel_cd,
    fc.fuel_group_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    mf.formula_identifier,
    mf.parameter_cd AS formula_parameter_cd,
    mf.equation_cd
   FROM camdecmpswks.vw_mp_hrly_op_data vwhod
     JOIN camdecmpswks.hrly_fuel_flow hff ON vwhod.hour_id::text = hff.hour_id::text
     JOIN camdecmpswks.hrly_param_fuel_flow hpff ON hff.hrly_fuel_flow_id::text = hpff.hrly_fuel_flow_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hff.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpswks.monitor_system ms ON hpff.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.monitor_formula mf ON hpff.mon_form_id::text = mf.mon_form_id::text;
