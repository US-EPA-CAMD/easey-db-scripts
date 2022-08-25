CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_param_fuel_flow (hrly_param_ff_id, hrly_fuel_flow_id, hour_id, mon_plan_id, mon_loc_id, rpt_period_id, calendar_year, quarter, begin_date, begin_hour, mon_sys_id, mon_form_id, parameter_cd, param_val_fuel, calc_param_val_fuel, sample_type_cd, operating_condition_cd, segment_num, parameter_uom_cd, fuel_cd, fuel_group_cd, system_identifier, sys_type_cd, sys_designation_cd, formula_identifier, formula_parameter_cd, equation_cd) AS
SELECT
    hrly_param_ff_id, hff.hrly_fuel_flow_id, vwHod.hour_id, mon_plan_id, vwHod.mon_loc_id, vwHod.rpt_period_id, calendar_year, quarter, vwHod.begin_date, vwHod.begin_hour, ms.mon_sys_id, hpff.mon_form_id, hpff.parameter_cd, param_val_fuel, calc_param_val_fuel, sample_type_cd, hpff.operating_condition_cd, segment_num, parameter_uom_cd, fc.fuel_cd, fc.fuel_group_cd, system_identifier, sys_type_cd, sys_designation_cd, formula_identifier, mf.parameter_cd AS formula_parameter_cd, equation_cd
    FROM camdecmpswks.vw_mp_hrly_op_data vwHod
    INNER JOIN camdecmpswks.hrly_fuel_flow hff
        ON vwHod.hour_id = hff.hour_id
    INNER JOIN camdecmpswks.hrly_param_fuel_flow hpff
        ON hff.hrly_fuel_flow_id = hpff.hrly_fuel_flow_id
    LEFT OUTER JOIN camdecmpsmd.fuel_code fc
        ON hff.fuel_cd = fc.fuel_cd
    LEFT OUTER JOIN camdecmpswks.monitor_system ms
        ON hpff.mon_sys_id = ms.mon_sys_id
    LEFT OUTER JOIN camdecmpswks.monitor_formula mf
        ON hpff.mon_form_id = mf.mon_form_id;