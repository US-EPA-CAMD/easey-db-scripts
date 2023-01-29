DO $$
DECLARE
	datasetCode text := 'CO2CALC';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'CO2 Calculation', 25, 'CO2 Calculation data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'CO2 Calculation', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'co2c_modc', 'co2cMODC', 'CO2C MODC'),
		(datatableId, 5, 'co2c_pma', 'co2cPMA', 'CO2C PMA'),
		(datatableId, 6, 'rpt_pct_o2', 'rptPCTO2', 'Rpt. % O2'),
		(datatableId, 7, 'pct_o2_used', 'pctO2Used', '% O2 Used in Calc. '),
		(datatableId, 8, 'o2_modc', 'o2MODC', 'O2 MODC'),
		(datatableId, 9, 'pct_h2o_used', 'pctH2OUsed', '% H2O Used in Calc.'),
		(datatableId, 10, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 11, 'fc_factor', 'fcFactor', 'Fc-Factor'),
		(datatableId, 12, 'fd_factor', 'fdFactor', 'Fd-Factor'),
		(datatableId, 13, 'formula_cd', 'formulaCode', 'CO2 Formula Code'),
		(datatableId, 14, 'rpt_pct_co2', 'rptPCTCO2', 'Rpt. % CO2'),
		(datatableId, 15, 'calc_pct_co2', 'calcPCTCO2', 'Calc. % CO2'),
		(datatableId, 16, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;