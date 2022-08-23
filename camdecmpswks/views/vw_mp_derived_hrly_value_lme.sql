CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_lme (derv_id, mon_plan_id, mon_loc_id, hour_id, rpt_period_id, calendar_year, quarter, begin_date, begin_hour, parameter_cd, unadjusted_hrly_value, adjusted_hrly_value, modc_cd, mon_sys_id, mon_form_id, pct_available, diluent_cap_ind, operating_condition_cd, segment_num, fuel_cd, system_identifier, sys_type_cd, sys_designation_cd, formula_identifier, formula_parameter_cd, equation_cd) AS
SELECT
    *
    FROM camdecmpswks.vw_mp_derived_hrly_value
    WHERE parameter_cd IN ('SO2M', 'CO2M', 'NOXM', 'HIT');