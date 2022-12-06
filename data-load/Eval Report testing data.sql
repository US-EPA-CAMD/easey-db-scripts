-- MONITOR PLAN REPORT
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('16bd8bc5-baca-4fc4-b034-d3884d58e03d', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, null, null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'CAPAC', 'MP', 'N', 'di', current_timestamp, 'jwhitehead', null);

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
)
VALUES (uuid_generate_v4(), '16bd8bc5-baca-4fc4-b034-d3884d58e03d', current_date, 431,
		'You reported [datefield2] which is prior to [datefield1] for [key]',
		'chk_log_comment', 612, 6, 'source_table', 'row_id', null, null, null, null, null, null, null, 'A', 'CRIT1', null, 'CAPAC-1', null);

-- QA REPORT (SINGLE TEST)
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-1', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-1', 0, null, 'LINE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'ERR');

INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('519e88e7-6539-43ba-9501-58aad9f69657', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 'jason-test-1', null, null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '8', 'NONCRIT', 'MISC', 'TEST', 'N', 'di', current_timestamp, 'jwhitehead', null);

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
)
VALUES (uuid_generate_v4(), '519e88e7-6539-43ba-9501-58aad9f69657', current_date, 2088
		,'You reported a TestDescription, but this is not appropriate for this test type. Use the TestComment field to enter additional information about the test.'
		,'chk_log_comment', 3121, 6, 'source_table', 'row_id', 'jason-test-1', null, null, null, null, null, null, 'B', 'NONCRIT', null, 'TEST-14', null);

-- QA REPORT (BATCH)
-- ONE
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-2', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-2', 0, null, 'CYCLE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'ERR');

INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('58ad39a3-ee66-4fc3-95a9-ed2c67e6302d', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 'jason-test-2', null, null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '-1', 'FATAL', 'CYCLE', 'TEST', 'N', 'di', current_timestamp, 'jwhitehead', 'batch-id-1');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
)
VALUES (uuid_generate_v4(), '58ad39a3-ee66-4fc3-95a9-ed2c67e6302d', current_date, 1544
		,'You did not provide [fieldname], which is required for [key]'
		,'chk_log_comment', 2734, 6, 'source_table', 'row_id', 'jason-test-2', null, null, null, null, null, null, 'A', 'FATAL', null, 'CYCLE-2', null);

-- TWO
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-3', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-3', 0, null, 'LINE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'INFO');

INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('175db6c2-a3f2-468c-adf5-735fa97d3ba8', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 'jason-test-3', null, null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '9', 'INFORM', 'LINTEST', 'TEST', 'N', 'di', current_timestamp, 'jwhitehead', 'batch-id-1');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
)
VALUES (uuid_generate_v4(), '175db6c2-a3f2-468c-adf5-735fa97d3ba8', current_date, 266
		,'The begin and end hour range for this test did not occur within an active period for the associated component and did not occur during the certification period.'
		,'chk_log_comment', 7088, 6, 'source_table', 'row_id', 'jason-test-3', null, null, null, null, null, null, 'D', 'INFORM', null, 'LINEAR-2', null);


select * from camdecmpswks.component where mon_loc_id in ('5','6','7');
select * from camdecmpswks.monitor_system where mon_loc_id in ('5','6','7');

select uuid_generate_v4()
select * from camdecmpsmd.eval_score_code
select * from camdecmpsmd.severity_code
select * from camdecmpsmd.category_code where process_cd = 'QACALC'
select * from camdecmpsmd.process_code where process_group_cd = 'QA'

select * from camdecmpsmd.check_catalog where check_type_cd = 'TEST' order by check_number
select * from camdecmpsmd.rule_check where check_catalog_id = 1740
select * from camdecmpsmd.check_catalog_result where check_catalog_id = 1740

select * from camdecmpswks.vw_mp_evaluation_results where monitorplanid = 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A'
select * from camdecmpswks.vw_qa_evaluation_results where mon_plan_id = 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A'
select * from camdecmpswks.vw_qa_evaluation_results where mon_plan_id = 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A' and batch_id = 'batch-id-1'
select * from camdecmpswks.vw_qa_evaluation_results where test_sum_id = 'jason-test-1'
select * from camdecmpswks.vw_qa_evaluation_results where test_sum_id = 'jason-test-2'
select * from camdecmpswks.vw_qa_evaluation_results where test_sum_id = 'jason-test-3'
