-- View: camdecmpswks.vw_mp_monitor_load

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_load;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_load
 AS
 SELECT loc.mon_plan_id,
    loc.fac_id,
    loc.oris_code,
    loc.location_name,
    ml.load_id,
    ml.mon_loc_id,
    ml.load_analysis_date,
    ml.begin_date,
    ml.begin_hour,
    ml.end_date,
    ml.end_hour,
    ml.max_load_value,
    ml.second_normal_ind,
    ml.up_op_boundary,
    ml.low_op_boundary,
    ml.normal_level_cd,
    ml.second_level_cd,
    ml.max_load_uom_cd
   FROM camdecmpswks.monitor_load ml
     JOIN camdecmpswks.vw_mp_monitor_location loc ON ml.mon_loc_id::text = loc.mon_loc_id::text;
