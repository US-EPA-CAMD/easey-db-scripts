-- View: camdecmpswks.vw_mp_derived_hrly_value_h2o

DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_h2o;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_h2o
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = 'H2O'::text;
