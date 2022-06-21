-- View: camdecmpswks.vw_qa_test_summary_ff2lbas

-- DROP VIEW camdecmpswks.vw_qa_test_summary_ff2lbas;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ff2lbas
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.begin_date,
    ts.begin_hour,
    ts.end_date,
    ts.end_hour,
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
    ff.fuel_flow_baseline_id,
    ff.accuracy_test_number,
    ff.pei_test_number,
    ff.avg_fuel_flow_rate,
    ff.avg_load,
    ff.baseline_fuel_flow_load_ratio,
    ff.fuel_flow_load_uom_cd,
    ff.avg_hrly_hi_rate,
    ff.baseline_ghr,
    ff.ghr_uom_cd,
    ff.nhe_cofiring,
    ff.nhe_ramping,
    ff.nhe_low_range
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.fuel_flow_to_load_baseline ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FF2LBAS'::text;
