-- View: camdecmpswks.vw_location_reporting_frequency

-- DROP VIEW camdecmpswks.vw_location_reporting_frequency;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_reporting_frequency
 AS
 SELECT rf.mon_plan_rf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    mp.mon_plan_id,
    rf.report_freq_cd,
    rf.begin_rpt_period_id,
    brp.year_quarter AS begin_quarter,
    rf.end_rpt_period_id,
    erp.year_quarter AS end_quarter,
    brp.quarter_begin_date AS begin_date,
    erp.quarter_end_date AS end_date
   FROM camdecmpswks.monitor_plan_reporting_freq rf
     JOIN camdecmpswks.monitor_plan mp ON rf.mon_plan_id::text = mp.mon_plan_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON mp.mon_plan_id::text = mpl.mon_plan_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.vw_reporting_period brp ON rf.begin_rpt_period_id = brp.rpt_period_id
     LEFT JOIN camdecmpswks.vw_reporting_period erp ON rf.end_rpt_period_id = erp.rpt_period_id;
