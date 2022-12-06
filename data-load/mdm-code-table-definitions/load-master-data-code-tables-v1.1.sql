DO $$
DECLARE
	datasetCode text;
	datatableId integer;
BEGIN
----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'control-equip-param-codes';
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'MDM', 'Control Equipment Parameter Codes & Descriptions', null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Control Equipment Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.control_equip_param_code', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'control_equip_param_cd', 'controlEquipParamCode', 'Control Equipment Parameter Code'),
		(datatableId, 2, 'control_equip_param_desc', 'controlEquipParamDescription', 'Control Equipment Parameter Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'parameter-codes';
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'MDM', 'Parameter Codes & Descriptions', null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Parameter Codes & Descriptions', 'SELECT * FROM camdecmpsmd.parameter_code', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'parameter_cd', 'parameterCode', 'Parameter Code'),
		(datatableId, 2, 'parameter_cd_description', 'parameterDescription', 'Parameter Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'source-category-codes';
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'MDM', 'Source Category Codes & Descriptions', null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Source Category Codes & Descriptions', 'SELECT * FROM camdmd.source_category_code', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'source_category_cd', 'sourceCategoryCode', 'Source Category Code'),
		(datatableId, 2, 'source_category_description', 'sourceCategoryDescription', 'Source Category Description');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'state-codes';
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'MDM', 'State Codes & Descriptions', null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'State Codes & Descriptions', 'SELECT * FROM camdmd.state_code', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'state_cd', 'stateCode', 'State Code'),
		(datatableId, 2, 'state_name', 'stateName', 'State Name'),
		(datatableId, 3, 'epa_region', 'epaRegion', 'EPA Region');

----------------------------------------------------------------------------------------------------------------------------
	datasetCode := 'transaction-type-codes';
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'MDM', 'Transation Type Codes & Descriptions', null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Transation Type Codes & Descriptions', 'SELECT * FROM camdmd.transaction_type_code', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'trans_type_cd', 'transactionTypeCode', 'Transaction Type Code'),
		(datatableId, 2, 'trans_type_description', 'transactionTypeDescription', 'Transaction Type Description');
END $$;