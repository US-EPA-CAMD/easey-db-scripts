-- REPORT
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('MP_EVAL', 'Monitoring Plan Evaluation Report', 'Evaluation complete with no errors or messages');
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('TEST_EVAL', 'QA/Certification Tests Evaluation Report', 'Evaluation complete with no errors or messages');
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('MP', 'Monitoring Plan Printout Report', 'There is no data for the specified monitor Plan');
/*
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('QCE_EVAL', 'QA/Certification Events Evaluation Report', 'Evaluation complete with no errors or messages');
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('TEE_EVAL', 'Test Extensions/Exemptions Evaluation Report', 'Evaluation complete with no errors or messages');
INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES('EM_EVAL', 'Emissions Evaluation Report', 'Evaluation complete with no errors or messages');
*/

-- REPORT DETAIL
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'MP_EVAL'), 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_mp_evaluation_results($1)', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'TEST_EVAL'), 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_qa_test_evaluation_results($1, $2, $3)', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'MP'), 1, 'Reporting Frequency', 'SELECT * FROM camdecmpswks.rpt_mp_reporting_frequency($1)', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'MP'), 2, 'Location Attributes', 'SELECT * FROM camdecmpswks.rpt_mp_location_attribute($1)', null);
/*
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'QCE_EVAL'), 1, 'Evaluation Results', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'TEE_EVAL'), 1, 'Evaluation Results', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'EM_EVAL'), 1, 'General Errors', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'EM_EVAL'), 2, 'Test Data Errors', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'EM_EVAL'), 3, 'Hourly Data Errors', null);
INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES((SELECT report_id FROM camdecmpsaux.report WHERE report_type_cd = 'EM_EVAL'), 4, 'Summary Data Errors', null);
*/


-- REPORT COLUMN
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(1, 'unitStack', 'Unit/Stack', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(2, 'severityCode', 'Severity', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(3, 'category', 'Category', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(4, 'checkCode', 'Check Code', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(5, 'resultMessage', 'Result Message', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(1, 'unitStack', 'Unit/Stack', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(2, 'testType', 'Test Type', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(3, 'testNumber', 'Test Number', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(4, 'testPeriod', 'Test Period', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(5, 'sysCompType', 'System/Component/Type', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(6, 'severityCode', 'Severity', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(7, 'checkCode', 'Check Code', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(8, 'resultMessage', 'Result Message', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(1, 'unitStack', 'Unit/Stack', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(2, 'frequency', 'Frequency', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(3, 'beginQuarter', 'Begin Quarter', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(4, 'endQuarter', 'End Quarter', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(1, 'unitStack', 'Unit/Stack', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(2, 'ductIndicator', 'Duct Indicator', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(3, 'groundElevation', 'Ground Elevation', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(4, 'stackHeight', 'Stack Height', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(5, 'crossAreaExit', 'Cross Area Exit', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(6, 'crossAreaFlow', 'Cross Area Flow', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(7, 'materialCode', 'Material Code', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(8, 'shapeCode', 'Shape Code', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(9, 'beginDate', 'Begin Date', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
	VALUES(10, 'endDate', 'End Date', (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));


-- REPORT PARAMETER
INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(1, 'monitorPlanId', null, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP_EVAL' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(1, 'monitorPlanId', null, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(2, 'testId', null, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));
INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(3, 'batchView', false, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'TEST_EVAL' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(1, 'monitorPlanId', null, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 1));

INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
	VALUES(1, 'monitorPlanId', null, (SELECT report_detail_id FROM camdecmpsaux.report_detail rd JOIN camdecmpsaux.report r USING(report_id) WHERE r.report_type_cd = 'MP' AND rd.position = 2));
