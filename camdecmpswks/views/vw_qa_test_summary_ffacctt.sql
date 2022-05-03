-- View: camdecmpswks.vw_qa_test_summary_ffacctt

-- DROP VIEW camdecmpswks.vw_qa_test_summary_ffacctt;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ffacctt
 AS
 SELECT ts.test_sum_id,
    ff.trans_ac_id,
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
    ff.low_level_accuracy,
    ff.low_level_accuracy_spec_cd,
    ff.mid_level_accuracy,
    ff.mid_level_accuracy_spec_cd,
    ff.high_level_accuracy,
    ff.high_level_accuracy_spec_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.trans_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FFACCTT'::text;
