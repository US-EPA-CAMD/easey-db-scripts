-- View: camdecmpswks.vw_qa_test_summary

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.calc_test_result_cd,
    rp.calendar_year,
    rp.quarter,
    ts.test_description,
    ts.rpt_period_id,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ts.injection_protocol_cd,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ff.reinstall_date,
    ff.reinstall_hour,
    udt.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    udt.operating_condition_cd,
    occ.op_condition_cd_description,
    COALESCE(flc.op_level_cd, flr.op_level_cd) AS op_level_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.fuel_flowmeter_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
     LEFT JOIN camdecmpswks.unit_default_test udt ON ts.test_sum_id::text = udt.test_sum_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON udt.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON udt.operating_condition_cd::text = occ.operating_condition_cd::text
     LEFT JOIN camdecmpswks.flow_to_load_check flc ON ts.test_sum_id::text = flc.test_sum_id::text
     LEFT JOIN camdecmpswks.flow_to_load_reference flr ON ts.test_sum_id::text = flr.test_sum_id::text;
