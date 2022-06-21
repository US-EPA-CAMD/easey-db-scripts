-- View: camdecmpswks.vw_qa_test_summary_f2lref

-- DROP VIEW camdecmpswks.vw_qa_test_summary_f2lref;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_f2lref
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
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
    fr.op_level_cd,
    fr.flow_load_ref_id,
    fr.avg_ref_method_flow,
    fr.rata_test_num,
    fr.avg_gross_unit_load,
    fr.ref_flow_load_ratio,
    fr.ref_ghr,
    fr.avg_hrly_hi_rate,
    fr.calc_sep_ref_ind
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.flow_to_load_reference fr ON ts.test_sum_id::text = fr.test_sum_id::text
  WHERE ts.test_type_cd::text = 'F2LREF'::text;
