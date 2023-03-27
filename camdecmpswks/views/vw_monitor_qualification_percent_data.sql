-- View: camdecmpswks.vw_monitor_qualification_percent_data

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification_percent_data;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification_percent_data
 AS
 SELECT mpl.mon_loc_id,
    mql.mon_qual_id,
    mql.begin_date,
    mql.end_date,
    mqp.qual_year
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_qualification mql ON mql.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.monitor_qualification_pct mqp ON mqp.mon_qual_id::text = mql.mon_qual_id::text;
