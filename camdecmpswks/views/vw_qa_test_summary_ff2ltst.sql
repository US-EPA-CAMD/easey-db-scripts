-- View: camdecmpswks.vw_qa_test_summary_ff2ltst

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ff2ltst;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ff2ltst
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    rp.calendar_year,
    rp.quarter,
    ts.rpt_period_id,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ff.fuel_flow_load_id,
    ff.test_basis_cd,
    ff.avg_diff,
    ff.num_hrs,
    ff.nhe_cofiring,
    ff.nhe_ramping,
    ff.nhe_low_range
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.fuel_flow_to_load_check ff ON ts.test_sum_id::text = ff.test_sum_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_type_cd::text = 'FF2LTST'::text;
