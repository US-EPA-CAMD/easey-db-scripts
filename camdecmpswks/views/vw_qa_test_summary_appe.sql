-- View: camdecmpswks.vw_qa_test_summary_appe

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_appe;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_appe
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.test_reason_cd,
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
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
  WHERE ts.test_type_cd::text = 'APPE'::text;
