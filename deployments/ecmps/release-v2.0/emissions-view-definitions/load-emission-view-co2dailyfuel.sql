DO $$
DECLARE
	datasetCode text := 'CO2DAILYFUEL';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'CO2 Daily Fuel Sampling View', 22, 'CO2 Daily Fuel Sampling data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'CO2 Daily Fuel Sampling', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date', 'date', 'Date'),
		(datatableId, 2, 'rpt_unadjusted_co2_mass', 'rptUnadjustedCO2Mass', 'Rpt. Unadjusted CO2 Mass (ton)'),
		(datatableId, 3, 'rpt_adjusted_daily_co2_mass', 'rptAdjustedDailyCO2Mass', 'Rpt. CO2 Mass Adjusted for Fly Ash (ton)'),
		(datatableId, 4, 'rpt_sorbent_rltd_co2_mass', 'rptSorbentRltdCO2Mass', 'Rpt. Sorbent-related CO2 Mass (ton)'),
		(datatableId, 11, 'rpt_total_daily_co2_mass', 'rptTotalDailyCO2Mass', 'Rpt. Total Daily CO2 Mass (ton)'),
		(datatableId, 13, 'error_codes', 'errorCodes', 'Daily Errors');
END $$;