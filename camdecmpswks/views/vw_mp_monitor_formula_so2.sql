-- View: camdecmpswks.vw_mp_monitor_formula_so2

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_formula_so2;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula_so2
 AS
 SELECT mf.mon_form_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    mf.parameter_cd,
    mf.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON mf.mon_loc_id::text = vwml.mon_loc_id::text
  WHERE mf.parameter_cd::text = 'SO2'::text;
