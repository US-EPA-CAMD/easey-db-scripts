-- View: camdecmpswks.vw_evem_summary_value

DROP VIEW IF EXISTS camdecmpswks.vw_evem_summary_value;

CREATE OR REPLACE VIEW camdecmpswks.vw_evem_summary_value
 AS
 SELECT sv.sum_value_id,
    ml.mon_plan_id,
    sv.rpt_period_id,
    sv.mon_loc_id,
    sv.parameter_cd,
    sv.current_rpt_period_total,
    sv.calc_current_rpt_period_total,
    sv.os_total,
    sv.calc_os_total,
    sv.year_total,
    sv.calc_year_total
   FROM camdecmpswks.summary_value sv
     JOIN camdecmpswks.vw_mp_monitor_location ml ON sv.mon_loc_id::text = ml.mon_loc_id::text;
