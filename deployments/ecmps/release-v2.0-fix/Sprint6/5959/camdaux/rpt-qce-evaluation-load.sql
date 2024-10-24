DO $$
DECLARE
	datasetCode text := 'QCE_EVAL';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
	VALUES(datasetCode, groupCode, 'QA/Certification Events Evaluation Report', 'Evaluation completed with no errors or informational messages.');
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO1C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'facilityId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM camdecmpswks.rpt_qa_cert_event_evaluation_results($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'eventCode', 'Event Code'),
		(datatableId, 3, 'eventDateHour', 'Event Date/Hr'),
		(datatableId, 4, 'systemIdType', 'System ID/Type'),
		(datatableId, 5, 'componentIdType', 'Component ID/Type'),
		(datatableId, 6, 'severityCode', 'Severity'),
		(datatableId, 7, 'checkCode', 'Check Code'),
		(datatableId, 8, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'qceId', null);
END $$;
