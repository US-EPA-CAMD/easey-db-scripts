DO $$
DECLARE
	datasetCode text := 'LTFF';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Long Term Fuel Flow View', 23, 'Long Term Fuel Flow data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Long Term Fuel Flow', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'fuel_flow_system_id', 'fuelFlowSystemId', 'Fuel Flow System ID'),
		(datatableId, 2, 'system_type', 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'fuel_type', 'fuelTypeCode', 'Fuel Type'),
		(datatableId, 4, 'period_cd', 'periodCode', 'Fuel Flow Period Code'),
		(datatableId, 5, 'fuel_flow', 'fuelFlow', 'Total Fuel Flow'),
		(datatableId, 6, 'fuel_flow_uom', 'fuelFlowUOMCode', 'Fuel Flow UOM'),
		(datatableId, 7, 'gross_calorific_value', 'grossCalorificValue', 'GCV'),
		(datatableId, 8, 'gcv_uom', 'gcvUOMCode', 'GCV UOM'),
		(datatableId, 9, 'rpt_heat_input', 'rptHeatInput', 'Rpt. Heat Input Total (mmBtu)'),
		(datatableId, 10, 'calc_heat_input', 'calcHeatInput', 'Calc. Heat Input Total (mmBtu)');
END $$;