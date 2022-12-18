-- View: camdecmpswks.vw_monitor_qualification_lme

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification_lme;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification_lme
 AS
 SELECT ml.mon_loc_id,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id,
    lme.mon_lme_id,
    lme.mon_qual_id,
    lme.qual_data_year,
    lme.so2_tons,
    lme.nox_tons,
    lme.op_hours,
    mq.qual_type_cd
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_qualification_lme lme ON mq.mon_qual_id::text = lme.mon_qual_id::text;
