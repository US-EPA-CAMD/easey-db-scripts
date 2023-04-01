DO $$
DECLARE
	datasetCode text := 'NSPS4T';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'NSPS4T Summary View', 27, 'NSPS4T Summary data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'NSPS4T Summary', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'emission_standard', 'emissionStandard', 'CO2 Emission Standard'),
		(datatableId, 2, 'modus_value_and_uom', 'modusValueUOMCode', 'MODUS'),
		(datatableId, 3, 'electrical_load_type', 'electricalLoadType', 'Electrical Load'),
		(datatableId, 4, 'compliance_period_ended', 'compliancePeriodEnded', 'Compliance Period Ended'),
		(datatableId, 5, 'compliance_period_begin_month', 'compliancePeriodBeginMonth', 'Compliance Beginning Month/Year'),
		(datatableId, 6, 'compliance_period_end_month', 'compliancePeriodEndMonth', 'Compliance Ending Month/Year'),
		(datatableId, 7, 'avg_co2_emission_rate_and_uom', 'avgCO2EmissionRateUOMCode', 'Average CO2 Emission Rate'),
		(datatableId, 8, 'pct_valid_op_hours', 'pctValidOpHours', 'Percent Valid Op Hours'),
		(datatableId, 9, 'co2_violation', 'co2Violation', 'Violation of CO2 Standard'),
		(datatableId, 10, 'annual_energy_sold', 'annualEnergySold', 'Annual Energy Sold'),
		(datatableId, 11, 'annual_energy_sold_type', 'annualEnergySoldType', 'Annual Energy Type'),
		(datatableId, 12, 'annual_potential_output', 'annualPotentialOutput', 'Annual Potential Output (MWh)');
END $$;