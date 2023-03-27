-- View: camdecmpswks.vw_mp_monitor_default_mnof

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_mnof;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_mnof
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'MNOF'::text;
