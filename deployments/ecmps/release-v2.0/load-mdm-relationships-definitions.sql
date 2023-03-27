DO $$
DECLARE
	groupCode text := 'MDMREL';
	datasetCode text;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'defaults';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Default Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Defaults', 'SELECT * FROM camdecmpsmd.vw_defaults_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_code', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'operating_condition_code', 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 3, 'unit_of_measure_code', 'defaultUnitsOfMeasureCode', 'Default Units Of Measure Code'),
		(datatableId, 4, 'purpose_code', 'defaultPurposeCode', 'Default Purpose Code'),
		(datatableId, 5, 'fuel_code', 'fuelCode', 'Fuel Code'),
		(datatableId, 6, 'source_code', 'defaultSourceCode', 'Default Source Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'formulas';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Formula Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Formulas', 'SELECT * FROM camdecmpsmd.vw_formula_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_code', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'formula_code', 'formulaCode', 'Formula Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'loads';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Load Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Loads', 'SELECT * FROM camdecmpsmd.vw_load_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'unit_of_measure_code', 'maximumLoadUnitsOfMeasureCode', 'Max Load Units Of Measure Code'),
		(datatableId, 2, 'normal_level', 'normalLevelCode', 'Normal Operating Level Code'),
		(datatableId, 3, 'second_level', 'secondLevelCode', 'Second Operating Level Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'mats-methods';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP MATS Method Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP MATS Methods', 'SELECT * FROM camdecmpsmd.vw_matsmethods_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_code', 'supplementalMATSParameterCode', 'MATS Parameter Code'),
		(datatableId, 2, 'method_Code', 'supplementalMATSMonitoringMethodCode', 'MATS Method Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'methods';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Method Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Methods', 'SELECT * FROM camdecmpsmd.vw_methods_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_code', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'method_Code', 'monitoringMethodCode', 'Method Code'),
		(datatableId, 3, 'bypass_approach_code', 'bypassApproachCode', 'Bypass Approach Code'),
		(datatableId, 4, 'substitute_data_code', 'substituteDataCode', 'Substitute Data Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'lee-qualifications';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP LEE Qualification Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP LEE Qualifications', 'SELECT * FROM camdecmpsmd.vw_quallee_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_code', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'unit_of_standard_code', 'unitsOfStandard', 'Units Of Measure Code'),
		(datatableId, 3, 'qual_lee_test_type_cd', 'qualificationTestType', 'Qualification Test Type Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'spans';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Span Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Spans', 'SELECT * FROM camdecmpsmd.vw_span_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'component_type_code', 'componentTypeCode', 'Component Type Code'),
		(datatableId, 2, 'unit_of_measure_code', 'spanUnitsOfMeasureCode', 'Units Of Measure Code'),
		(datatableId, 3, 'span_scale_code', 'spanScaleCode', 'Span Scale Code'),
		(datatableId, 4, 'span_method_code', 'spanMethodCode', 'Span Method Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'system-components';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP System Component Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP System Components', 'SELECT * FROM camdecmpsmd.vw_systemcomponent_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'component_type_code', 'componentTypeCode', 'Component Type Code'),
		(datatableId, 2, 'sample_aquisition_method_code', 'sampleAcquisitionMethodCode', 'Sample Acquisition Method Code'),
		(datatableId, 3, 'basis_code', 'basisCode', 'Basis Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'system-fuel-flows';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP System Fuel Flow Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP System Fuel Flows', 'SELECT * FROM camdecmpsmd.vw_systemfuel_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'unit_of_measure_code', 'systemFuelFlowUOMCode', 'System Fuel Flow UOM Code'),
		(datatableId, 2, 'max_rate_source_code', 'maximumFuelFlowRateSourceCode', 'Max Fuel Flow Rate Source Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-summaries';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data QA Test Summary Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for QA Test Summary', 'SELECT * FROM camdecmpsmd.vw_test_summary_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_type_code', 'testTypeCode', 'Test Type Code'),
		(datatableId, 2, 'test_reason_code', 'testReasonCode', 'Test Reason Code'),
		(datatableId, 3, 'test_result_code', 'testResultCode', 'Test Result Code'),
		(datatableId, 4, 'gas_level_code', 'gasLevelCode', 'Gas Level Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'unit-controls';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Unit Control Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Unit Controls', 'SELECT * FROM camdecmpsmd.vw_unitcontrol_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'controlequipparamcode', 'controlEquipParamCode', 'Control Equip Parameter Code'),
		(datatableId, 2, 'control_code', 'controlCode', 'Control Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'unit-fuels';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data MP Unit Fuel Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for MP Unit Fuels', 'SELECT * FROM camdecmpsmd.vw_unitfuel_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_type_cd', 'fuelCode', 'Fuel Code'),
		(datatableId, 2, 'fuel_indicator_cd', 'indicatorCode', 'Indicator Code'),
		(datatableId, 1, 'dem_gcv', 'demGCV', 'GCV Demonstration Code'),
		(datatableId, 2, 'dem_so2', 'demSO2', 'SO2 Demonstration Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'unit-defaults';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Master Data Unit Default Relationships');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Returns related Master Data codes for Unit Defaults', 'SELECT * FROM camdecmpsmd.vw_unit_default_master_data_relationships')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_code', 'fuelCode', 'Fuel Code'),
		(datatableId, 2, 'operating_condition_code', 'operatingConditionCode', 'Operating Condition Code');
----------------------------------------------------------------------------------------------------------------------------
END $$;
