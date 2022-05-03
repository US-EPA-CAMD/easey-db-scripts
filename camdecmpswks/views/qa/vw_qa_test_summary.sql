CREATE OR REPLACE  VIEW camdecmpswks.vw_qa_test_summary (test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, calendar_year, quarter, test_description, rpt_period_id, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, span_scale_cd, test_comment, injection_protocol_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, fac_id, location_identifier, component_type_cd, component_identifier, acq_cd, system_identifier, sys_type_cd, sys_designation_cd, reinstall_date, reinstall_hour, fuel_cd, fuel_group_cd, unit_fuel_cd, fuel_cd_description, operating_condition_cd, op_condition_cd_description, op_level_cd) AS
SELECT
    ts.test_sum_id, ts.mon_loc_id, ts.mon_sys_id, ts.component_id, ts.test_num, ts.gp_ind, ts.test_type_cd, ts.test_reason_cd, ts.test_result_cd, ts.calc_test_result_cd, rp.calendar_year, rp.quarter, ts.test_description, ts.rpt_period_id, ts.begin_date, ts.begin_hour, ts.begin_min, ts.end_date, ts.end_hour, ts.end_min, ts.span_scale_cd, ts.test_comment, ts.injection_protocol_cd, ts.last_updated, ts.updated_status_flg, ts.needs_eval_flg, ts.chk_session_id, ts.userid, ts.add_date, ts.update_date, ml.fac_id, COALESCE(ml.stack_name, ml.unitid) AS location_identifier, c.component_type_cd, c.component_identifier, c.acq_cd, ms.system_identifier, ms.sys_type_cd, ms.sys_designation_cd, ff.reinstall_date, ff.reinstall_hour, udt.fuel_cd, fc.fuel_group_cd, fc.unit_fuel_cd, fc.fuel_cd_description, udt.operating_condition_cd, occ.op_condition_cd_description, COALESCE(flc.op_level_cd, flr.op_level_cd) AS op_level_cd
    FROM camdecmpswks.test_summary AS ts
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ts.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.monitor_system AS ms
        ON ts.mon_sys_id = ms.mon_sys_id
    LEFT OUTER JOIN camdecmpswks.component AS c
        ON ts.component_id = c.component_id
    LEFT OUTER JOIN camdecmpsmd.reporting_period AS rp
        ON ts.rpt_period_id = rp.rpt_period_id
    LEFT OUTER JOIN camdecmpswks.fuel_flowmeter_accuracy AS ff
        ON ts.test_sum_id = ff.test_sum_id
    LEFT OUTER JOIN camdecmpswks.unit_default_test AS udt
        ON ts.test_sum_id = udt.test_sum_id
    LEFT OUTER JOIN camdecmpsmd.fuel_code AS fc
        ON udt.fuel_cd = fc.fuel_cd
    LEFT OUTER JOIN camdecmpsmd.operating_condition_code AS occ
        ON udt.operating_condition_cd = occ.operating_condition_cd
    LEFT OUTER JOIN camdecmpswks.flow_to_load_check AS flc
        ON ts.test_sum_id = flc.test_sum_id
    LEFT OUTER JOIN camdecmpswks.flow_to_load_reference AS flr
        ON ts.test_sum_id = flr.test_sum_id;