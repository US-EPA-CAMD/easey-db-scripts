DO $$
DECLARE
datasetCode text := 'QAT_FEEDBACK';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
VALUES(datasetCode, groupCode, 'QA/Cert Test List', 'QA/Cert Test List does not exist.');
------------------------------------------------------------------------------------------------
tableOrder := tableOrder + 1;
INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM {SCHEMA}.get_qatest_feedback($1)')
    RETURNING datatable_id INTO datatableId;

/***** COLUMNS *****/
INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
VALUES
    (datatableId, 1, 'unit_stack_pipe', 'unitStackPipe', 'Unit/Stack/Pipe'),
    (datatableId, 2, 'test_type_cd', 'testTypeCd', 'Test Type'),
    (datatableId, 3, 'test_num', 'testNum', 'Test Number'),
    (datatableId, 4, 'sys_comp', 'sysComp', 'Sys / Comp ID / Type'),
    (datatableId, 5, 'end_test', 'endTest', 'End Date/Quarter');
/***** PARAMETERS *****/
INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
VALUES
    (datatableId, 1, 'testId', null);
------------------------------------------------------------------------------------------------
datasetCode := 'QCE_FEEDBACK';
DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
VALUES(datasetCode, groupCode, 'QA/Cert Events List', 'QA/Cert Events List does not exist.');

tableOrder := 1;
INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM {SCHEMA}.get_qacert_event_feedback($1)')
    RETURNING datatable_id INTO datatableId;

/***** COLUMNS *****/
INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
VALUES
    (datatableId, 1, 'unit_stack_pipe', 'unitStackPipe', 'Unit/Stack/Pipe'),
    (datatableId, 2, 'qa_cert_event_cd', 'qaCertEventCd', 'Event Code'),
    (datatableId, 3, 'sys_id_type', 'sysIdType', 'System ID/Type'),
    (datatableId, 4, 'component', 'component', 'Comp ID / Type'),
    (datatableId, 5, 'qa_cert_datehour', 'qaCertDateHour', 'Event Date/Hour');
/***** PARAMETERS *****/
INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
VALUES
    (datatableId, 1, 'qceId', null);
------------------------------------------------------------------------------------------------
datasetCode := 'TEE_FEEDBACK';
DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
VALUES(datasetCode, groupCode, 'Test Extensions and Exemptions List', 'Test Extensions and Exemptions List does not exist.');

tableOrder := 1;
INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM {SCHEMA}.get_test_extension_exemption_feedback($1)')
    RETURNING datatable_id INTO datatableId;

/***** COLUMNS *****/
INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
VALUES
    (datatableId, 1, 'unit_stack_pipe', 'unitStackPipe', 'Unit/Stack/Pipe'),
    (datatableId, 2, 'extens_exempt_cd', 'extensExemptCd', 'Extension/Exemption Code'),
    (datatableId, 3, 'tee_year_quarter', 'teeYearQrt', 'Quarter'),
    (datatableId, 4, 'sys_id_type', 'sysIdType', 'System ID/Type'),
    (datatableId, 5, 'component', 'component', 'Comp ID / Type'),
    (datatableId, 6, 'span_fuel', 'spanFuel', 'Span Scale/Fuel');
/***** PARAMETERS *****/
INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
VALUES
    (datatableId, 1, 'teeid', null);
------------------------------------------------------------------------------------------------
END $$;
