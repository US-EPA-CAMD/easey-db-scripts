DO $$
DECLARE
	datasetCode text := 'MASSOILCALC';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Mass Oil Calculation View', 26, 'Mass Oil Calculation data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Mass Oil Calculation', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'fuel_sys_id', 'fuelSystemIdentifier', 'Fuel System ID'),
		(datatableId, 4, 'oil_type', 'oilType', 'Oil Type'),
		(datatableId, 5, 'fuel_use_time', 'fuelUseTime', 'Fuel Use Time'),
		(datatableId, 6, 'rpt_volumetric_oil_flow', 'rptVolumetricOILFlow', 'Rpt. Volumetric Oil Flow'),
		(datatableId, 7, 'calc_volumetric_oil_flow', 'calcVolumetricOILFlow', 'Volumetric Oil Flow Used in Calc.'),
		(datatableId, 8, 'volumetric_oil_flow_uom', 'volumetricOILFlowUOM', 'Volumetric Oil Flow Units of Measure'),
		(datatableId, 9, 'volumetric_oil_flow_sodc', 'volumetricOILFlowSodc', 'Volumetric Oil Flow SODC'),
		(datatableId, 10, 'oil_density', 'oilDensity', 'Oil Density'),
		(datatableId, 11, 'oil_density_uom', 'oilDensityUOM', 'Oil Density Units of Measure'),
		(datatableId, 12, 'oil_density_sampling_type', 'oilDensitySamplingType', 'Oil Density Sampling Type'),
		(datatableId, 13, 'rpt_mass_oil_flow', 'rptMassOILFlow', 'Rpt. Mass Oil Flow (lb/hr)'),
		(datatableId, 14, 'calc_mass_oil_flow', 'calcMassOILFlow', 'Calc. Mass Oil Flow (lb/hr)'),
		(datatableId, 16, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;