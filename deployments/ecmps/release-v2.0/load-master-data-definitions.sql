DO $$
DECLARE
	groupCode text := 'MDM';
	datasetCode text;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'analytical-principle-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Analytical Principle Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Analytical Principle Codes & Descriptions', 'SELECT * FROM camdecmpsmd.analytical_principle_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'analytical_principle_cd', 'analyticalPrincipleCode', 'Analytical Principle Code'),
		(datatableId, 2, 'analytical_principle_cd_description', 'analyticalPrincipleDescription', 'Analytical Principle Description');

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'control-equip-param-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Control Equipment Parameter Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Control Equipment Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.control_equip_param_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'control_equip_param_cd', 'controlEquipParamCode', 'Control Equipment Parameter Code'),
		(datatableId, 2, 'control_equip_param_desc', 'controlEquipParamDescription', 'Control Equipment Parameter Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'parameter-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Parameter Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.parameter_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_cd', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'parameter_cd_description', 'parameterDescription', 'Parameter Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'source-category-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Source Category Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Source Category Codes & Descriptions', 'SELECT * FROM camdmd.source_category_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'source_category_cd', 'sourceCategoryCode', 'Source Category Code'),
		(datatableId, 2, 'source_category_description', 'sourceCategoryDescription', 'Source Category Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'state-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'State Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'State Codes & Descriptions', 'SELECT * FROM camdmd.state_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'state_cd', 'stateCode', 'State Code'),
		(datatableId, 2, 'state_name', 'stateName', 'State Name'),
		(datatableId, 3, 'epa_region', 'epaRegion', 'EPA Region');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'transaction-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Transation Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Transation Type Codes & Descriptions', 'SELECT * FROM camdmd.transaction_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'trans_type_cd', 'transactionTypeCode', 'Transaction Type Code'),
		(datatableId, 2, 'trans_type_description', 'transactionTypeDescription', 'Transaction Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'accuracy-spec-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Accuracy Spec Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Accuracy Spec Codes & Descriptions', 'SELECT * FROM camdecmpsmd.accuracy_spec_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'accuracy_spec_cd', 'accuracySpecCode', 'Accuracy Spec Code'),
		(datatableId, 2, 'accuracy_spec_cd_description', 'accuracySpecDescription', 'Accuracy Spec Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'accuracy-test-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Accuracy Test Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Accuracy Test Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.accuracy_test_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'acc_test_method_cd', 'accuracyTestMethodCode', 'Accuracy Test Method Code'),
		(datatableId, 2, 'acc_test_method_cd_description', 'accuracyTestMethodDescription', 'Accuracy Test Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'acquisition-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Acquisition Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Acquisition Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.acquisition_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'acq_cd', 'acquisitionMethodCode', 'Acquisition Method Code'),
		(datatableId, 2, 'acq_cd_description', 'acquisitionMethodDescription', 'Acquisition Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'analyzer-range-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Analyzer Range Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Analyzer Range Codes & Descriptions', 'SELECT * FROM camdecmpsmd.analyzer_range_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'analyzer_range_cd', 'analyzerRangeCode', 'Analyzer Range Code'),
		(datatableId, 2, 'analyzer_range_cd_description', 'analyzerRangeDescription', 'Analyzer Range Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'aps-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'APS Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'APS Codes & Descriptions', 'SELECT * FROM camdecmpsmd.aps_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'aps_cd', 'apsCode', 'APS Code'),
		(datatableId, 2, 'aps_description', 'apsDescription', 'APS Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'basis-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Basis Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Basis Codes & Descriptions', 'SELECT * FROM camdecmpsmd.basis_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'basis_cd', 'basisCode', 'Basis Code'),
		(datatableId, 2, 'basis_cd_description', 'basisDescription', 'Basis Description'),
		(datatableId, 3, 'basis_category', 'basisCategory', 'Basis Category');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'bypass-approach-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Bypass Approach Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Bypass Approach Codes & Descriptions', 'SELECT * FROM camdecmpsmd.bypass_approach_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'bypass_approach_cd', 'bypassApproachCode', 'Bypass Approach Code'),
		(datatableId, 2, 'bypass_approach_cd_description', 'bypassApproachDescription', 'Bypass Approach Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'component-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Component Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Component Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.component_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'component_type_cd', 'componentTypeCode', 'Component Type Code'),
		(datatableId, 2, 'component_type_cd_description', 'componentTypeDescription', 'Component Type Description'),
		(datatableId, 3, 'span_indicator', 'spanIndicator', 'Span Indicator'),
		(datatableId, 4, 'parameter_cd', 'parameterCode', 'Parameter Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'default-purpose-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Default Purpose Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Default Purpose Codes & Descriptions', 'SELECT * FROM camdecmpsmd.default_purpose_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'default_purpose_cd', 'defaultPurposeCode', 'Default Purpose Code'),
		(datatableId, 2, 'def_purpose_cd_description', 'defaultPurposeDescription', 'Default Purpose Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'default-source-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Default Source Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Default Source Codes & Descriptions', 'SELECT * FROM camdecmpsmd.default_source_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'default_source_cd', 'defaultSourceCode', 'Default Source Code'),
		(datatableId, 2, 'default_source_cd_description', 'defaultSourceDescription', 'Default Source Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'demonstration-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Demonstration Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Demonstration Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.dem_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'dem_method_cd', 'demonstrationMethodCode', 'Demonstration Method Code'),
		(datatableId, 2, 'dem_method_description', 'demonstrationMethodDescription', 'Demonstration Method Description'),
		(datatableId, 3, 'dem_parameter', 'parameterCode', 'Parameter Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'equation-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Equation Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Equation Codes & Descriptions', 'SELECT * FROM camdecmpsmd.equation_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'equation_cd', 'equationCode', 'Equation Code'),
		(datatableId, 2, 'equation_cd_description', 'equationDescription', 'Equation Description'),
		(datatableId, 3, 'moisture_ind', 'moistureIndicator', 'Moisture Indicator');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'fuel-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Fuel Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Fuel Codes & Descriptions', 'SELECT * FROM camdecmpsmd.fuel_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_cd', 'fuelCode', 'Fuel Code'),
		(datatableId, 2, 'fuel_group_cd', 'fuelGroupCode', 'Fuel Group Code'),
		(datatableId, 3, 'unit_fuel_cd', 'unitFuelCode', 'Unit Fuel Code'),
		(datatableId, 4, 'fuel_cd_description', 'fuelDescription', 'Fuel Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'fuel-flow-period-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Fuel Flow Period Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Fuel Flow Period Codes & Descriptions', 'SELECT * FROM camdecmpsmd.fuel_flow_period_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_flow_period_cd', 'fuelFlowPeriodCode', 'Fuel Flow Period Code'),
		(datatableId, 2, 'ff_period_cd_description', 'fuelFlowPeriodDescription', 'Fuel Flow Period Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'fuel-group-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Fuel Group Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Fuel Group Codes & Descriptions', 'SELECT * FROM camdecmpsmd.fuel_group_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_group_cd', 'fuelGroupCode', 'Fuel Group Code'),
		(datatableId, 2, 'fuel_group_description', 'fuelGroupDescription', 'Fuel Group Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'fuel-indicator-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Fuel Indicator Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Fuel Indicator Codes & Descriptions', 'SELECT * FROM camdecmpsmd.fuel_indicator_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_indicator_cd', 'fuelIndicatorCode', 'Fuel Indicator Code'),
		(datatableId, 2, 'fuel_indicator_description', 'fuelIndicatorDescription', 'Fuel Indicator Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'gas-level-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Gas Level Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Gas Level Codes & Descriptions', 'SELECT * FROM camdecmpsmd.gas_level_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'gas_level_cd', 'gasLevelCode', 'Gas Level Code'),
		(datatableId, 2, 'gas_level_description', 'gasLevelDescription', 'Gas Level Description'),
		(datatableId, 3, 'cal_category', 'calibrationCategory', 'Calibration Category');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'gas-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Gas Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Gas Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.gas_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'gas_type_cd', 'gasTypeCode', 'Gas Type Code'),
		(datatableId, 2, 'gas_type_description', 'gasTypeDescription', 'Gas Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'indicator-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Indicator Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Indicator Codes & Descriptions', 'SELECT * FROM camdecmpsmd.indicator_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'indicator_cd', 'indicatorCode', 'Indicator Code'),
		(datatableId, 2, 'indicator_cd_description', 'indicatorDescription', 'Indicator Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'injection-protocol-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Injection Protocol Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Injection Protocol Codes & Descriptions', 'SELECT * FROM camdecmpsmd.injection_protocol_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'injection_protocol_cd', 'injectionProtocolCode', 'Injection Protocol Code'),
		(datatableId, 2, 'injection_protocol_description', 'injectionProtocolDescription', 'Injection Protocol Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'material-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Material Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Material Codes & Descriptions', 'SELECT * FROM camdecmpsmd.material_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'material_cd', 'materialCode', 'Material Code'),
		(datatableId, 2, 'material_code_description', 'materialDescription', 'Material Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'mats-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'MATS Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'MATS Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'mats_method_cd', 'matsMethodCode', 'MATS Method Code'),
		(datatableId, 2, 'mats_method_description', 'matsMethodDescription', 'MATS Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'mats-method-parameter-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'MATS Method Parameter Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'MATS Method Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_method_parameter_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'mats_method_parameter_cd', 'matsMethodParameterCode', 'MATS Method Parameter Code'),
		(datatableId, 2, 'mats_method_param_description', 'matsMethodParameterDescription', 'MATS Method Parameter Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'max-rate-source-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Max Rate Source Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Max Rate Source Codes & Descriptions', 'SELECT * FROM camdecmpsmd.max_rate_source_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'max_rate_source_cd', 'mMaxRateSourceCode', 'Max Rate Source Code'),
		(datatableId, 2, 'max_rate_source_cd_description', 'maxRateSourceDescription', 'Max Rate Source Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'method_cd', 'methodCode', 'Method Code'),
		(datatableId, 2, 'method_cd_description', 'methodDescription', 'Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'modc-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'MODC Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'MODC Codes & Descriptions', 'SELECT * FROM camdecmpsmd.modc_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'modc_cd', 'modcCode', 'MODC Code'),
		(datatableId, 2, 'modc_description', 'modcDescription', 'MODC Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'electrical-load-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Electrical Load Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Electrical Load Codes & Descriptions', 'SELECT * FROM camdecmpsmd.nsps4t_electrical_load_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'electrical_load_cd', 'electricalLoadCode', 'Electrical Load Code'),
		(datatableId, 2, 'electrical_load_description', 'electricalloadDescription', 'Electrical Load Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'emission-standard-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Emission Standard Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Emission Standard Codes & Descriptions', 'SELECT * FROM camdecmpsmd.nsps4t_emission_standard_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'emission_standard_cd', 'emissionStandardCode', 'Electrical Load Code'),
		(datatableId, 2, 'emission_standard_description', 'emissionStandardDescription', 'Electrical Load Description'),
		(datatableId, 3, 'emission_standard_uom_cd', 'emissionStandardUOMCode', 'Electrical Load Description'),
		(datatableId, 4, 'emission_standard_load_cd', 'emissionStandardLoadCode', 'Electrical Load Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'operating-condition-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Operating Condition Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Operating Condition Codes & Descriptions', 'SELECT * FROM camdecmpsmd.operating_condition_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'operating_condition_cd', 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 2, 'op_condition_cd_description', 'operatingConditionDescription', 'Operating Condition Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'operating-level-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Operating Level Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Operating Level Codes & Descriptions', 'SELECT * FROM camdecmpsmd.operating_level_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'op_level_cd', 'opLevelCode', 'Operating Level Code'),
		(datatableId, 2, 'op_level_cd_description', 'opLevelDescription', 'Operating Level Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'pressure-measure-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Pressure Measure Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Pressure Measure Codes & Descriptions', 'SELECT * FROM camdecmpsmd.pressure_measure_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'pressure_meas_cd', 'pressureMeasureCode', 'Pressure Measure Code'),
		(datatableId, 2, 'pressure_meas_cd_description', 'pressureMeasureDescription', 'Pressure Measure Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'probe-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Probe Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Probe Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.probe_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'probe_type_cd', 'probeTypeCode', 'Probe Type Code'),
		(datatableId, 2, 'probe_type_cd_description', 'probeTypeDescription', 'Probe Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'qa-cert-event-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'QA Certification Event Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'QA Certification Event Codes & Descriptions', 'SELECT * FROM camdecmpsmd.qa_cert_event_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'qa_cert_event_cd', 'qaCertEventCode', 'QA Certification Event Code'),
		(datatableId, 2, 'qa_cert_event_cd_description', 'qaCertEventDescription', 'QA Certification Event Description'),
		(datatableId, 3, 'qa_cert_category', 'qaCertEventCategory', 'QA Certification Event Category');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'qualification-data-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Qualification Data Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Qualification Data Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.qual_data_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'qual_data_type_cd', 'qualificationDataTypeCode', 'Qualification Data Type Code'),
		(datatableId, 2, 'qual_data_type_cd_description', 'qualificationDataTypeDescription', 'Qualification Data Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'qualification-lee-test-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Qualification LEE Test Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Qualification LEE Test Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.qual_lee_test_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'qual_lee_test_type_cd', 'qualifiationLEETestTypeCode', 'Qualification LEE Test Type Code'),
		(datatableId, 2, 'qual_lee_test_type_description', 'qualifiationLEETestTypeDescription', 'Qualification LEE Test Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'qualification-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Qualification Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Qualification Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.qual_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'qual_type_cd', 'qualificationTypeCode', 'Qualification Type Code'),
		(datatableId, 2, 'qual_type_cd_description', 'qualificationTypeDescription', 'Qualification Type Description'),
		(datatableId, 3, 'qual_type_group_cd', 'qualificationTypeGroupCode', 'Qualification Type Grouip Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'rata-frequency-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Rata Frequency Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Rata Frequency Codes & Descriptions', 'SELECT * FROM camdecmpsmd.rata_frequency_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'rata_frequency_cd', 'rataFrequencyCode', 'Rata Frequency Code'),
		(datatableId, 2, 'rata_frequency_cd_description', 'rataFrequencyDescription', 'Rata Frequency Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'reference-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Reference Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Reference Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.ref_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'ref_method_cd', 'referenceMethodCode', 'Reference Method Code'),
		(datatableId, 2, 'ref_method_cd_description', 'referenceMethodDescription', 'Reference Method Description'),
		(datatableId, 3, 'parameter_cd', 'parameterCode', 'Parameter Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'required-test-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Required Test Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Required Test Codes & Descriptions', 'SELECT * FROM camdecmpsmd.required_test_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'required_test_cd', 'requiredTestCode', 'Required Test Code'),
		(datatableId, 2, 'required_test_cd_description', 'requiredTestDescription', 'Required Test Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'run-status-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Run Status Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Run Status Codes & Descriptions', 'SELECT * FROM camdecmpsmd.run_status_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'run_status_cd', 'runStatusCode', 'Run Status Code'),
		(datatableId, 2, 'run_status_description', 'runStatusDescription', 'Run Status Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'sample-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Sample Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Sample Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.sample_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sample_type_cd', 'sampleTypeCode', 'Sample Type Code'),
		(datatableId, 2, 'sample_type_cd_description', 'sampleTypeDescription', 'Sample Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'shape-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Shape Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Shape Codes & Descriptions', 'SELECT * FROM camdecmpsmd.shape_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'shape_cd', 'shapeCode', 'Shape Code'),
		(datatableId, 2, 'shape_cd_description', 'shapeDescription', 'Shape Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'sod-mass-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'SOD Mass Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'SOD Mass Codes & Descriptions', 'SELECT * FROM camdecmpsmd.sod_mass_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sod_mass_cd', 'sodMassCode', 'SOD Mass Code'),
		(datatableId, 2, 'sod_mass_cd_description', 'sodMassDescription', 'SOD Mass Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'sod-volumetric-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'SOD Volumetric Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'SOD Volumetric Codes & Descriptions', 'SELECT * FROM camdecmpsmd.sod_volumetric_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sod_volumetric_cd', 'sodVolumetriCode', 'SOD Volumetri Code'),
		(datatableId, 2, 'sod_volumetric_cd_description', 'sodVolumetriDescription', 'SOD Volumetri Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'span-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Span Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Span Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.span_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'span_method_cd', 'spanMethodCode', 'Span Method Code'),
		(datatableId, 2, 'span_method_cd_description', 'spanMethodDescription', 'Span Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'span-scale-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Span Scale Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Span Scale Codes & Descriptions', 'SELECT * FROM camdecmpsmd.span_scale_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'span_scale_cd', 'spanScaleCode', 'Span Scale Code'),
		(datatableId, 2, 'span_scale_cd_description', 'spanScaleDescription', 'Span Scale Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'substitute-data-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Substitute Data Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Substitute Data Codes & Descriptions', 'SELECT * FROM camdecmpsmd.substitute_data_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sub_data_cd', 'substituteDataCode', 'Substitute Data Code'),
		(datatableId, 2, 'sub_data_cd_description', 'substituteDataDescription', 'Substitute Data Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'system-designation-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'System Designation Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'System Designation Codes & Descriptions', 'SELECT * FROM camdecmpsmd.system_designation_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sys_designation_cd', 'systemDesignationCode', 'System Designation Code'),
		(datatableId, 2, 'sys_designation_cd_description', 'systemDesignationDescription', 'System Designation Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'system-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'System Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'System Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.system_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'sys_type_cd', 'systemTypeCode', 'System Type Code'),
		(datatableId, 2, 'sys_type_description', 'systemTypeDescription', 'System Type Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-basis-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Basis Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Basis Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_basis_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_basis_cd', 'testBasisCode', 'Test Basis Code'),
		(datatableId, 2, 'test_basis_description', 'testBasisDescription', 'Test Basis Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-claim-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Claim Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Claim Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_claim_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_claim_cd', 'testClaimCode', 'Test Claim Code'),
		(datatableId, 2, 'test_claim_cd_description', 'testClaimDescription', 'Test Claim Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-frequency-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Frequency Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Frequency Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_frequency_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_frequency_cd', 'testFrequencyCode', 'Test Frequency Code'),
		(datatableId, 2, 'test_frequency_cd_description', 'testFrequencyDescription', 'Test Frequency Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-reason-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Reason Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Reason Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_reason_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_reason_cd', 'testReasonCode', 'Test Reason Code'),
		(datatableId, 2, 'test_reason_cd_description', 'testReasonDescription', 'Test Reason Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-result-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Result Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Result Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_result_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_result_cd', 'testResultCode', 'Test Result Code'),
		(datatableId, 2, 'test_result_cd_description', 'testResultDescription', 'Test Result Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_type_cd', 'testTypeCode', 'Test Type Code'),
		(datatableId, 2, 'test_type_cd_description', 'testTypeDescription', 'Test Type Description'),
		(datatableId, 3, 'group_cd', 'testTypeGroupCode', 'Test Type Group Code');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'test-type-group-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Test Type Group Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Test Type Group Codes & Descriptions', 'SELECT * FROM camdecmpsmd.test_type_group_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_type_group_cd', 'testTypeGroupCode', 'Test Type Group Code'),
		(datatableId, 2, 'test_type_group_cd_description', 'testTypeGroupDescription', 'Test Type Group Description'),
		(datatableId, 3, 'child_depth', 'childDepth', 'Number of Child Levels');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'train-qa-status-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Train QA Status Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Train QA Status Codes & Descriptions', 'SELECT * FROM camdecmpsmd.train_qa_status_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'train_qa_status_cd', 'trainQAStatusCode', 'Train QA Status Code'),
		(datatableId, 2, 'train_qa_status_description', 'trainQAStatusDescription', 'Train QA Status Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'units-of-measure-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Units of Measure Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Units of Measure Codes & Descriptions', 'SELECT * FROM camdecmpsmd.units_of_measure_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'uom_cd', 'unitOfMeasureCode', 'Units of Measure Code'),
		(datatableId, 2, 'uom_cd_description', 'unitOfMeasureDescription', 'Units of Measure Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'waf-method-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'WAF Method Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'WAF Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.waf_method_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'waf_method_cd', 'wafMethodCode', 'WAF Method Code'),
		(datatableId, 2, 'waf_method_cd_description', 'wafMethodDescription', 'WAF Method Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'es-severity-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Error Suppression Severity Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Error Suppression Severity Codes & Descriptions', 'SELECT * FROM camdecmpsmd.severity_code WHERE es_type_ind = 1 ORDER BY severity_level')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'severity_cd', 'severityCode', 'Severity Code'),
		(datatableId, 2, 'severity_cd_description', 'severityDescription', 'Severity Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'es-reason-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Error Suppression Reason Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Error Suppression Reason Codes & Descriptions', 'SELECT * FROM camdecmpsmd.es_reason_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'es_reason_cd', 'errorSuppressionReasonCode', 'Error Suppresion Reason Code'),
		(datatableId, 2, 'es_reason_description', 'errorSuppressionReasonDescription', 'Error Suppression Reason Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'es-check-catalog-results';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Error Suppression Check Catalog Results');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Error Suppression Check Catalog Results', 'SELECT * FROM camdecmpsmd.vw_es_check_catalog_result')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'check_catalog_result_id', 'id', 'Check Catalog Result Id'),
		(datatableId, 2, 'check_type_cd', 'checkTypeCode', 'Check Type Code'),
		(datatableId, 3, 'check_type_cd_description', 'checkTypeDescription', 'Check Type Description'),
		(datatableId, 4, 'check_number', 'checkNumber', 'Check Number'),
		(datatableId, 5, 'check_result', 'checkResult', 'Check Result'),
		(datatableId, 6, 'es_match_loc_type_cd', 'locationTypeCode', 'Location Type Code'),
		(datatableId, 7, 'es_match_time_type_cd', 'timeTypeCode', 'Time Type Code'),
		(datatableId, 8, 'es_match_data_type_cd', 'dataTypeCode', 'Data Type Code'),
		(datatableId, 9, 'es_match_data_type_label', 'dataTypeLabel', 'Data Type Label'),
		(datatableId, 10, 'es_match_data_type_url', 'dataTypeUrl', 'Data Type Url');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'es-parameter-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Error Suppression Parameter Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Error Suppression Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.vw_es_parameter_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'check_type_cd', 'checkTypeCode', 'Check Type Code'),
		(datatableId, 2, 'check_number', 'checkNumber', 'Check Number'),
		(datatableId, 3, 'parameter_cd', 'parameterCode', 'Parameter Code'),
		(datatableId, 4, 'parameter_cd_description', 'parameterDescription', 'Parameter Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'extension-exemption-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Extension & Exemption Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Extension & Exemption Codes & Descriptions', 'SELECT * FROM camdecmpsmd.extension_exemption_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'extens_exempt_cd', 'extensionExemptionCode', 'Extension & Exemption Code'),
		(datatableId, 2, 'extens_exemp_cd_description', 'extensionExemptionDescription', 'Extension & Exemption Description');
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'gas-component-codes';
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, 'MDM', 'Gas Component Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Gas Component Codes & Descriptions', 'SELECT * FROM camdecmpsmd.vw_gas_component_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'code', 'gasComponentCode', 'Gas Component Code'),
		(datatableId, 2, 'description', 'gasComponentDescription', 'Gas Component Description'),
		(datatableId, 3, 'can_combine_ind', 'canCombineIndicator', 'Can Combine Indicator'),
		(datatableId, 4, 'balance_component_ind', 'balanceComponentIndicator', 'Balance Component Indicator'),
		(datatableId, 5, 'group_cd', 'groupCode', 'Group Code');
END $$;
