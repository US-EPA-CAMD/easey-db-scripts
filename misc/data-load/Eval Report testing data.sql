-- MONITOR PLAN REPORT
DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '16bd8bc5-baca-4fc4-b034-d3884d58e03d';
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QA TEST REPORT (SINGLE)
DELETE FROM camdecmpswks.test_summary WHERE test_sum_id = 'jason-test-1';
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-1', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-1', 0, null, 'LINE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '519e88e7-6539-43ba-9501-58aad9f69657';
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QA TEST REPORT (BATCH - ONE)
DELETE FROM camdecmpswks.test_summary WHERE test_sum_id = 'jason-test-2';
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-2', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-2', 0, null, 'CYCLE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '58ad39a3-ee66-4fc3-95a9-ed2c67e6302d';
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QA TEST REPORT (BATCH - TWO)
DELETE FROM camdecmpswks.test_summary WHERE test_sum_id = 'jason-test-3';
INSERT INTO camdecmpswks.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd, eval_status_cd)
VALUES ('jason-test-3', 6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'jason-test-3', 0, null, 'LINE', 'QA', 'PASSED', null, 117, null, current_date, 12, 30, current_date, 2, 30, null, null, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'L', null, 'INFO');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '175db6c2-a3f2-468c-adf5-735fa97d3ba8';
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QCE REPORT (SINGLE)
DELETE FROM camdecmpswks.qa_cert_event WHERE qa_cert_event_id = 'jason-qce-1';
INSERT INTO camdecmpswks.qa_cert_event(
	mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, eval_status_cd
)
VALUES (6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', '100', current_date, 12, '10', current_date, 15, current_date, 23, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'jason-qce-1', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '32fc2f59-7386-4a1a-9dc3-8717dc82a9bf';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('32fc2f59-7386-4a1a-9dc3-8717dc82a9bf', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, 'jason-qce-1', null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'EVENT', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', null);

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), '32fc2f59-7386-4a1a-9dc3-8717dc82a9bf', current_date, 5013
		,'You did not provide [fieldname], which is required for [key].'
		,'chk_log_comment', 1766, 6, 'source_table', 'row_id', 'A', 'CRIT1', 'QACERT-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QCE REPORT (BATCH - ONE)
DELETE FROM camdecmpswks.qa_cert_event WHERE qa_cert_event_id = 'jason-qce-2';
INSERT INTO camdecmpswks.qa_cert_event(
	mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, eval_status_cd
)
VALUES (6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', '100', current_date, 12, '10', current_date, 15, current_date, 23, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'jason-qce-2', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = 'e0b396da-b1ba-400f-9356-983a16833d18';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('e0b396da-b1ba-400f-9356-983a16833d18', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, 'jason-qce-2', null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'EVENT', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', 'batch-id-2');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), 'e0b396da-b1ba-400f-9356-983a16833d18', current_date, 5013
		,'You did not provide [fieldname], which is required for [key].'
		,'chk_log_comment', 1766, 6, 'source_table', 'row_id', 'A', 'CRIT1', 'QACERT-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QCE REPORT (BATCH - TWO)
DELETE FROM camdecmpswks.qa_cert_event WHERE qa_cert_event_id = 'jason-qce-3';
INSERT INTO camdecmpswks.qa_cert_event(
	mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, eval_status_cd
)
VALUES (6, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', '100', current_date, 12, '10', current_date, 15, current_date, 23, current_date, 'N', 'Y', null, 'jwhite', current_timestamp, current_timestamp, 'jason-qce-3', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '6c1e38d8-3144-45ee-a743-8edce12c0c7f';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('6c1e38d8-3144-45ee-a743-8edce12c0c7f', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, 'jason-qce-3', null, null, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'EVENT', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', 'batch-id-2');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), '6c1e38d8-3144-45ee-a743-8edce12c0c7f', current_date, 5013
		,'You did not provide [fieldname], which is required for [key].'
		,'chk_log_comment', 1766, 6, 'source_table', 'row_id', 'A', 'CRIT1', 'QACERT-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEE REPORT (SINGLE)
DELETE FROM camdecmpswks.test_extension_exemption WHERE test_extension_exemption_id = 'jason-tee-1';
INSERT INTO camdecmpswks.test_extension_exemption(
	test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, eval_status_cd
)
VALUES('jason-tee-1', 6, 121, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'PNG', 'RANGENU', current_date, 'N', 'Y', null, 260, 'jwhite', current_timestamp, current_timestamp, 'L', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = 'e00f289a-7024-42cc-bbf3-afceed380146';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('e00f289a-7024-42cc-bbf3-afceed380146', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, null, 'jason-tee-1', 121, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'TEE', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', null);

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), 'e00f289a-7024-42cc-bbf3-afceed380146', current_date, 2270
		,'You reported a Year/Quarter which is outside the range of acceptable values for this record.'
		,'chk_log_comment', 3316, 6, 'source_table', 'row_id', 'B', 'CRIT1', 'EXTEXEM-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEE REPORT (BATCH - ONE)
DELETE FROM camdecmpswks.test_extension_exemption WHERE test_extension_exemption_id = 'jason-tee-2';
INSERT INTO camdecmpswks.test_extension_exemption(
	test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, eval_status_cd
)
VALUES('jason-tee-2', 6, 121, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'PNG', 'RANGENU', current_date, 'N', 'Y', null, 260, 'jwhite', current_timestamp, current_timestamp, 'L', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = 'bb09ea59-b680-4314-b70e-a2f8f0fed078';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('bb09ea59-b680-4314-b70e-a2f8f0fed078', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, null, 'jason-tee-2', 121, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'TEE', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', 'batch_id-3');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), 'bb09ea59-b680-4314-b70e-a2f8f0fed078', current_date, 2270
		,'You reported a Year/Quarter which is outside the range of acceptable values for this record.'
		,'chk_log_comment', 3316, 6, 'source_table', 'row_id', 'B', 'CRIT1', 'EXTEXEM-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEE REPORT (BATCH - TWO)
DELETE FROM camdecmpswks.test_extension_exemption WHERE test_extension_exemption_id = 'jason-tee-3';
INSERT INTO camdecmpswks.test_extension_exemption(
	test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, eval_status_cd
)
VALUES('jason-tee-3', 6, 121, 'TWCORNEL5-5BCFD5B414474E1083A77A6B33A2F13D', 'TWCORNEL5-5D039680D4E84110B940314D7FBEE0F4', 'PNG', 'RANGENU', current_date, 'N', 'Y', null, 260, 'jwhite', current_timestamp, current_timestamp, 'L', 'ERR');

DELETE FROM camdecmpswks.check_session WHERE chk_session_id = '84247b08-3e16-4fb0-8fb9-4ab6112dc854';
INSERT INTO camdecmpswks.check_session(
	chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, eval_begin_date, eval_end_date, session_end_date, session_comment, eval_score_cd, severity_cd, category_cd, process_cd, updated_status_flg, di, last_updated, userid, batch_id
)
VALUES ('84247b08-3e16-4fb0-8fb9-4ab6112dc854', 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', null, null, 'jason-tee-3', 121, current_timestamp, current_date, current_date, current_timestamp, 'session_comment', '0', 'CRIT1', 'TEE', 'OTHERQA', 'N', 'di', current_timestamp, 'jwhitehead', 'batch_id-3');

INSERT INTO camdecmpswks.check_log(
	chk_log_id, chk_session_id, begin_date, rule_check_id,
	result_message,
	chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, check_result, severity_cd, check_cd
)
VALUES (uuid_generate_v4(), '84247b08-3e16-4fb0-8fb9-4ab6112dc854', current_date, 2270
		,'You reported a Year/Quarter which is outside the range of acceptable values for this record.'
		,'chk_log_comment', 3316, 6, 'source_table', 'row_id', 'B', 'CRIT1', 'EXTEXEM-1');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from camdecmpswks.component where mon_loc_id in ('5','6','7');
select * from camdecmpswks.monitor_system where mon_loc_id in ('5','6','7');

select uuid_generate_v4()
select * from camdecmpsmd.severity_code
select * from camdecmpsmd.eval_score_code
select * from camdecmpsmd.reporting_period
select * from camdecmpsmd.extension_exemption_code
select * from camdecmpsmd.category_code where process_cd = 'OTHERQA'
select * from camdecmpsmd.process_code where process_group_cd = 'QA'

select * from camdecmpsmd.check_catalog where check_type_cd = 'QACERT' order by check_number
select * from camdecmpsmd.check_catalog where check_type_cd = 'EXTEXEM' order by check_number
select * from camdecmpsmd.rule_check where check_catalog_id = 1363
select * from camdecmpsmd.check_catalog_result where check_catalog_id = 1363
select * from camdecmpsmd.response_catalog where response_catalog_id = 41057

select * from camdecmpswks.rpt_mp_evaluation_results('TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A');
select * from camdecmpswks.rpt_qa_test_evaluation_results('jason-test-1');
select * from camdecmpswks.rpt_qa_test_evaluation_results('jason-test-2');
select * from camdecmpswks.rpt_qa_test_evaluation_results('jason-test-3');
select * from camdecmpswks.rpt_qa_cert_event_evaluation_results('jason-qce-1');
select * from camdecmpswks.rpt_qa_cert_event_evaluation_results('jason-qce-2');
select * from camdecmpswks.rpt_qa_cert_event_evaluation_results('jason-qce-3');
select * from camdecmpswks.rpt_test_extension_exemption_evaluation_results('jason-tee-1');
select * from camdecmpswks.rpt_test_extension_exemption_evaluation_results('jason-tee-2');
select * from camdecmpswks.rpt_test_extension_exemption_evaluation_results('jason-tee-3');
