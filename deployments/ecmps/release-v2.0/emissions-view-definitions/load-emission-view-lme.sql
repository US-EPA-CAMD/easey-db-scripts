DO $$
DECLARE
	datasetCode text := 'LME';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'LME View', 24, 'LME data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'LME', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'hi_modc', 'hiMODC', 'Heat  Input MODC'),
		(datatableId, 7, 'rpt_heat_input', 'rptHeatInput', 'Rpt. Heat Input Total (mmBtu)'),
		(datatableId, 8, 'calc_heat_input', 'calcHeatInput', 'Calc. Heat Input Total (mmBtu)'),
		(datatableId, 9, 'so2m_fuel_type', 'so2mFuelType', 'SO2M Fuel Type'),
		(datatableId, 10, 'so2_emiss_rate', 'so2EmissRate', 'Default SO2 Emission Rate (lb/mmBtu)'),
		(datatableId, 11, 'rpt_so2_mass', 'rptSO2Mass', 'Rpt. SO2 Mass (lb)'),
		(datatableId, 12, 'calc_so2_mass', 'calcSO2Mass', 'Calc. SO2 Mass (lb)'),
		(datatableId, 13, 'noxm_fuel_type', 'noxmFuelType', 'NOXM Fuel Type'),
		(datatableId, 14, 'operating_condition_cd', 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 15, 'nox_emiss_rate', 'noxEmissRate', 'Default NOx Emission Rate (lb/mmBtu)'),
		(datatableId, 16, 'rpt_nox_mass', 'rptNOXMass', 'Rpt. NOx Mass (lb)'),
		(datatableId, 17, 'calc_nox_mass', 'calcNOXMass', 'Calc. NOx Mass (lb)'),
		(datatableId, 18, 'co2m_fuel_type', 'co2mFuelType', 'CO2M Fuel Type'),
		(datatableId, 19, 'co2_emiss_rate', 'co2EmissRate', 'Default CO2 Emission Rate (ton/mmBtu)'),
		(datatableId, 20, 'rpt_co2_mass', 'rptCO2Mass', 'Rpt. CO2 Mass (ton)'),
		(datatableId, 21, 'calc_co2_mass', 'calcCO2Mass', 'Calc. CO2 Mass (ton)'),
		(datatableId, 22, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;