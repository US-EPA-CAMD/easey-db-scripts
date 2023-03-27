-- View: camdecmpswks.vw_mp_monitor_default

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default
 AS
 SELECT md.mondef_id,
    ml.mon_plan_id,
    md.mon_loc_id,
    md.parameter_cd,
    md.begin_date,
    md.begin_hour,
    md.end_date,
    md.end_hour,
    md.operating_condition_cd,
    md.default_value,
    md.default_uom_cd,
    md.default_purpose_cd,
    md.default_source_cd,
    md.fuel_cd,
    md.group_id
   FROM camdecmpswks.monitor_default md
     JOIN camdecmpswks.vw_mp_monitor_location ml ON md.mon_loc_id::text = ml.mon_loc_id::text;
