-- View: camdecmpswks.vw_monitor_load

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_load;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_load
 AS
 SELECT loc.fac_id,
    loc.oris_code,
    loc.location_identifier,
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
    ml.max_load_uom_cd,
    ml.begin_date + ((ml.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ml.end_date + ((ml.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_load ml
     JOIN camdecmpswks.vw_monitor_location loc ON ml.mon_loc_id::text = loc.mon_loc_id::text;
