-- View: camdecmpswks.vw_qa_test_summary_ffacc

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ffacc;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ffacc
 AS
 SELECT ts.test_sum_id,
    ff.fuel_flow_acc_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_result_cd,
    ts.test_reason_cd,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
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
    c.component_identifier,
    c.component_type_cd,
    c.acq_cd,
    ff.reinstall_date,
    ff.reinstall_hour,
    ff.acc_test_method_cd,
    ff.low_fuel_accuracy,
    ff.mid_fuel_accuracy,
    ff.high_fuel_accuracy
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.fuel_flowmeter_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FFACC'::text;
