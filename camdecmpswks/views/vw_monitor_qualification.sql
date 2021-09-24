-- View: camdecmpswks.vw_monitor_qualification

-- DROP VIEW camdecmpswks.vw_monitor_qualification;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification
 AS
 SELECT mq.mon_qual_id,
    ml.mon_loc_id,
    mq.qual_type_cd,
    mq.begin_date,
    mq.end_date,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text;
