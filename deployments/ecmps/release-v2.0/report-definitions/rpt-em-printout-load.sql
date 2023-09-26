DO $$
DECLARE
	datasetCode text := 'EM';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Emissions Printout Report');
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO3C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1, $2, $3, $4)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 3, 'locationInfo', 'Unit/Stack Info'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County'),
		(datatableId, 6, 'hidden1', 'HIDDEN'),
		(datatableId, 7, 'latitude', 'Latitude'),
		(datatableId, 8, 'longitude', 'Longitude'),
		(datatableId, 9, 'hidden2', 'HIDDEN'),
		(datatableId, 10, 'yearQuarter', 'Year/Quarter'),
		(datatableId, 11, 'totalHours', 'Total Hours'),
		(datatableId, 12, 'hidden3', 'HIDDEN');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'facilityId', null),
		(datatableId, 2, 'monitorPlanId', null),
		(datatableId, 3, 'year', null),
		(datatableId, 4, 'quarter', null);

-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'EMALL', 'SELECT * FROM {SCHEMA}.rpt_em_emission_view_all($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'opTime', 'Op Time'),
		(datatableId, 4, 'unitLoad', 'Load'),
		(datatableId, 5, 'loadUomCode', 'Load Units Of Measure'),
		(datatableId, 6, 'hiFormulaCode', 'HI Formula Code'),		
		(datatableId, 7, 'rptHiRate', 'Reported HI Rate'),
		(datatableId, 8, 'calcHiRate', 'Calculated HI Rate'),
		(datatableId, 9, 'so2FormulaCode', 'SO2 Formula Code'),
		(datatableId, 10, 'rptSo2MassRate', 'Reported SO2 Mass Rate'),
		(datatableId, 11, 'calcSo2MassRate', 'Calculated SO2 Mass Rate'),
		(datatableId, 12, 'noxRateFormulaCode', 'NOx Rate Formula'),
		(datatableId, 13, 'rptAdjNoxRate', 'Reported Adj. NOx Rate'),
		(datatableId, 14, 'calcAdjNoxRate', 'Calculated Adj. NOx Rate'),
		(datatableId, 15, 'noxMassFormulaCode', 'NOx Mass Formula Code'),
		(datatableId, 16, 'rptNoxMass', 'Reported NOx Mass Rate'),		
		(datatableId, 17, 'calcNoxMass', 'Calculated NOx Mass Rate'),
		(datatableId, 18, 'co2FormulaCode', 'CO2 Formula Code'),
		(datatableId, 19, 'rptCo2MassRate', 'Reported CO2 Mass Rate'),
		(datatableId, 20, 'calcCo2MassRate', 'Calcualted CO2 Mass Rate'),
		(datatableId, 21, 'errorCodes', 'Hourly Errors'),
		(datatableId, 22, 'adjFlowUsed', 'Adj.Flow Used'),
		(datatableId, 23, 'rptAdjFlow', 'Reported Adj. Flow'),
		(datatableId, 24, 'unadjFlow', 'Unadj. Flow');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'BACKSTOP', 'SELECT * FROM {SCHEMA}.rpt_em_daily_backstop($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'opDate', 'Op Date'),
		(datatableId, 3, 'dailyNoxm', 'Daily NOx Mass Rate (lb/hr'),
		(datatableId, 4, 'dailyHit', 'Daily Heat Input'),
		(datatableId, 5, 'dailyAvgNoxr', 'Daily Avg. NOx Rate (lb/mmBtu)'),
		(datatableId, 6, 'dailyNoxmExceed', 'Daily NOx Mass Exceedence'),		
		(datatableId, 7, 'cumulativeOsNoxmExceed', 'Cumulative NOx Mass Exceedence');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------

END $$;
