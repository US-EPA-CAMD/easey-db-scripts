-- View: camdecmpswks.vw_monitor_formula

-- DROP VIEW camdecmpswks.vw_monitor_formula;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_formula
 AS
 SELECT mf.mon_form_id,
    mf.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    mf.parameter_cd,
    mf.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation,
    ec.equation_cd_description,
    ec.moisture_ind,
    mf.begin_date + ((mf.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    mf.end_date + ((mf.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_monitor_location ml ON mf.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.equation_code ec ON mf.equation_cd::text = ec.equation_cd::text;
