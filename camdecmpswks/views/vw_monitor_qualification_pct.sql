-- View: camdecmpswks.vw_monitor_qualification_pct

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification_pct;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification_pct
 AS
 SELECT ml.mon_loc_id,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id,
    pct.mon_pct_id,
    mq.qual_type_cd,
    mq.begin_date,
    mq.end_date,
    pct.mon_qual_id,
    pct.qual_year,
    pct.yr1_qual_data_type_cd,
    pct.yr1_qual_data_year,
    pct.yr1_pct_value,
    pct.yr2_qual_data_type_cd,
    pct.yr2_qual_data_year,
    pct.yr2_pct_value,
    pct.yr3_qual_data_type_cd,
    pct.yr3_qual_data_year,
    pct.yr3_pct_value,
    pct.avg_pct_value
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_qualification_pct pct ON mq.mon_qual_id::text = pct.mon_qual_id::text;
