DO $$
DECLARE
	datasetCode text := 'EM_EVAL';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
	VALUES(datasetCode, groupCode, 'Emissions Evaluation Report', 'Evaluation completed with no errors or informational messages.');
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'FACINFO3C' AND sql_statement = 'SELECT * FROM {SCHEMA}.rpt_facility_information($1, $2, $3, $4)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO3C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1, $2, $3, $4)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 3, 'locationInfo', 'Unit/Stack Info'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County'),
		(datatableId, 6, 'hidden1', 'HIDDEN'),
		(datatableId, 7, 'hidden2', 'HIDDEN'),
		(datatableId, 8, 'yearQuarter', 'Year/Quarter'),
		(datatableId, 9, 'totalOPTime', 'Total OP Time'),
		(datatableId, 10, 'hidden3', 'HIDDEN');
	
	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'facilityId', null),
		(datatableId, 2, 'monitorPlanId', null),
		(datatableId, 3, 'year', null),
		(datatableId, 4, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'GENERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_general_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'GENERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_general_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'TESTERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_test_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'TESTERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_test_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'testTypeCode', 'Test Type'),
		(datatableId, 3, 'testDateTime', 'Date/Hr/Min'),
		(datatableId, 4, 'sysCompId', 'Sys / Comp Id'),
		(datatableId, 5, 'sysCompTypeScale', 'Sys / Comp Type / Scale'),
		(datatableId, 6, 'severityCode', 'Severity'),
		(datatableId, 7, 'checkCode', 'Check Code'),
		(datatableId, 8, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'QAERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_qa_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QAERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_qa_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'categoryDescription', 'Category'),
		(datatableId, 3, 'severityCode', 'Severity'),
		(datatableId, 4, 'checkResult', 'Check Result'),
		(datatableId, 5, 'resultMessage', 'Result Message'),
		(datatableId, 6, 'beginPeriod', 'Begin Date/Hr'),
		(datatableId, 7, 'endPeriod', 'End Date/Hr'),
		(datatableId, 8, 'consecutiveHours', 'Consecutive Hours');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'TRPERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_trap_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'TRPERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_trap_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'HRLYERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_hourly_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HRLYERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_hourly_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message'),
		(datatableId, 6, 'beginPeriod', 'Begin Date/Hr'),
		(datatableId, 7, 'endPeriod', 'End Date/Hr'),
		(datatableId, 8, 'consecutiveHours', 'Consecutive Hours');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'DLYERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_daily_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DLYERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_daily_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message'),
		(datatableId, 6, 'beginPeriod', 'Begin Date/Hr'),
		(datatableId, 7, 'endPeriod', 'End Date/Hr'),
		(datatableId, 8, 'consecutiveDays', 'Consecutive Days');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'SUMERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_summary_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'SUMERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_summary_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	DELETE FROM camdaux.dataparameter WHERE datatable_id = datatableId;
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'QUADTERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_nsps4t_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QUADTERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_nsps4t_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode AND table_order = tableOrder AND template_cd = 'ADTERR' AND sql_statement = 'SELECT * FROM camdecmpswks.rpt_em_evaluation_audit_error_results($1, $2, $3)';
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'ADTERR', 'SELECT * FROM camdecmpswks.rpt_em_evaluation_audit_error_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'checkCode', 'Check Code'),
		(datatableId, 4, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
END $$;
