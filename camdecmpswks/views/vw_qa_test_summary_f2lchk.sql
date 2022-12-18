-- View: camdecmpswks.vw_qa_test_summary_f2lchk

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_f2lchk;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_f2lchk
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.gp_ind,
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
    fc.flow_load_check_id,
    fc.test_basis_cd,
    fc.avg_abs_pct_diff,
    fc.num_hrs,
    fc.nhe_fuel,
    fc.nhe_ramping,
    fc.nhe_bypass,
    fc.nhe_pre_rata,
    fc.nhe_test,
    fc.nhe_main_bypass,
    fc.bias_adjusted_ind,
    fc.op_level_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.flow_to_load_check fc ON ts.test_sum_id::text = fc.test_sum_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_type_cd::text = 'F2LCHK'::text;
