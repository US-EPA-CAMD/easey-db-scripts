-- View: camdecmpswks.vw_qa_test_summary_rata

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_rata;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_rata
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
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
    r.rata_id,
    r.relative_accuracy,
    r.overall_bias_adj_factor,
    r.num_load_level,
    r.rata_frequency_cd,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.begin_date AS system_begin_date,
    ms.begin_hour AS system_begin_hour
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.rata r ON ts.test_sum_id::text = r.test_sum_id::text
  WHERE ts.test_type_cd::text = 'RATA'::text;
