-- View: camdecmpswks.vw_mp_monitor_formula

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_formula;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula
 AS
 SELECT mf.mon_form_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    mf.parameter_cd,
    ec.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation,
    vwml.fac_id,
    vwml.location_name,
    ec.equation_cd_description,
    ec.moisture_ind
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON mf.mon_loc_id::text = vwml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.equation_code ec ON mf.equation_cd::text = ec.equation_cd::text;
