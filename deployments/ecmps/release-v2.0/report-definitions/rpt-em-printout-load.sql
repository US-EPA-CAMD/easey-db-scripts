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
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'SUMVAL', 'SELECT * FROM {SCHEMA}.rpt_em_summary_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'parameterCode', 'Parameter Code'),
		(datatableId, 3, 'currentRptPeriodTotal', 'Current Reporting Period Total'),
		(datatableId, 4, 'calcCurrentRptPeriodTotal', 'Calculated Current Reporting Period Total'),
		(datatableId, 5, 'osTotal', 'OS Total'),
		(datatableId, 6, 'calcOsTotal', 'Calculated OS Total'),
		(datatableId, 7, 'yearTotal', 'Year Total'),
		(datatableId, 8, 'calcYearTotal', 'Calculated Year Total');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DLYTESTSUM', 'SELECT * FROM {SCHEMA}.rpt_em_daily_test_sum($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 4, 'dailyTestDate', 'Daily Test Date'),
		(datatableId, 5, 'dailyTestHour', 'Daily Test Hour'),
		(datatableId, 6, 'dailyTestMin', 'Daily Test Minute'),
		(datatableId, 7, 'testTypeCode', 'Test Type Code'),
		(datatableId, 8, 'testResultCode', 'Test Result Code'),
		(datatableId, 9, 'calcTestResultCode', 'Calculated Test Result Code'),
		(datatableId, 10, 'spanScaleCode', 'Span Scale Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DLYCAL', 'SELECT * FROM {SCHEMA}.rpt_em_daily_calibration($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'onlineOfflineInd', 'Online Offline Indicator'),
		(datatableId, 3, 'calcOnlineOfflineInd', 'Calculated Online Offline Indicator'),
		(datatableId, 4, 'zeroInjectionDate', 'Zero Injection Date'),
		(datatableId, 5, 'zeroInjectionHour', 'Zero Injection Hour'),
		(datatableId, 6, 'zeroInjectionMin', 'Zero Injection Minute'),
		(datatableId, 7, 'upscaleInjectionDate', 'Upscale Injection Date'),
		(datatableId, 8, 'upscaleInjectionHour', 'Upscale Injection Hour'),
		(datatableId, 9, 'upscaleInjectionMin', 'Upscale Injection Minute'),
		(datatableId, 10, 'zeroMeasuredValue', 'Zero Measured Value'),
		(datatableId, 11, 'upscaleMeasuredValue', 'Upscale Measured Value'),
		(datatableId, 12, 'zeroApsInd', 'Zero APS Indicator'),
		(datatableId, 13, 'calcZeroApsInd', 'Calculated Zero APS Indicator'),
		(datatableId, 14, 'upscaleApsInd', 'Upscale APS Indicator'),
		(datatableId, 15, 'calcUpscaleApsInd', 'Calculated Upscale APS Indicator'),
		(datatableId, 16, 'zeroCalError', 'Zero Calibration Error'),
		(datatableId, 17, 'calcZeroCalError', 'Calculated Zero Calibration Error'),
		(datatableId, 18, 'upscaleCalError', 'Upscale Calibration Error'),
		(datatableId, 19, 'calcUpscaleCalError', 'Calculated Upscale Calibration Error'),
		(datatableId, 20, 'zeroRefValue', 'Zero Reference Value'),
		(datatableId, 21, 'upscaleRefValue', 'Upscale Reference Value'),
		(datatableId, 22, 'vendorId', 'Vendor Id'),
		(datatableId, 23, 'cylinderIdentifier', 'Cylinder Identifier'),
		(datatableId, 24, 'expirationDate', 'Expiration Date'),
		(datatableId, 25, 'upscaleGasLevelCode', 'Upscale Gas Level Code'),
		(datatableId, 26, 'upscaleGasTypeCode', 'Upscale Gas Type Code'),
		(datatableId, 27, 'injectionProtocolCode', 'Injection Protocol Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'WKLYTESTSUM', 'SELECT * FROM {SCHEMA}.rpt_em_weekly_test_sum($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 4, 'testDate', 'Test Date'),
		(datatableId, 5, 'testHour', 'Test Hour'),
		(datatableId, 6, 'testMin', 'Test Minute'),
		(datatableId, 7, 'testTypeCode', 'Test Type Code'),
		(datatableId, 8, 'testResultCode', 'Test Result Code'),
		(datatableId, 9, 'calcTestResultCode', 'Calculated Test Result Code'),
		(datatableId, 10, 'spanScaleCode', 'Span Scale Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'WKLYSYSINT', 'SELECT * FROM {SCHEMA}.rpt_em_weekly_system_integrity($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'refValue', 'Reference Value'),
		(datatableId, 3, 'measuredValue', 'Measured Value'),
		(datatableId, 4, 'systemIntegrityError', 'System Integrity Error'),
		(datatableId, 5, 'apsInd', 'Aps Indicator'),
		(datatableId, 6, 'calcSystemIntegrityError', 'Calculated System Integrity Error'),
		(datatableId, 7, 'calcApsInd', 'Calculated Aps Indicator'),
		(datatableId, 8, 'gasLevelCode', 'Gas Level Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DLYEM', 'SELECT * FROM {SCHEMA}.rpt_em_daily_emissions($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'parameterCode', 'Parameter Code'),
		(datatableId, 3, 'beginDate', 'Begin Date'),
		(datatableId, 4, 'totalDailyEmission', 'Total Daily Emission'),
		(datatableId, 5, 'adjustedDailyEmission', 'Adjusted Daily Emission'),
		(datatableId, 6, 'sorbentMassEmission', 'Sorbent Mass Emission'),
		(datatableId, 7, 'unadjustedDailyEmission', 'Unadjusted Faily Emission'),
		(datatableId, 8, 'totalCarbonBurned', 'Total Carbon Burned'),
		(datatableId, 9, 'calcTotalDailyEmission', 'Calculated Total Daily Emission'),
		(datatableId, 10, 'calcTotalOpTime', 'Calculated Total Op Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DLYFUEL', 'SELECT * FROM {SCHEMA}.rpt_em_daily_fuel($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'fuelCode', 'Fuel Code'),
		(datatableId, 3, 'dailyFuelFeed', 'Daily Fuel Feed'),
		(datatableId, 4, 'carbonContentUsed', 'Carbon Content Used'),
		(datatableId, 5, 'fuelCarbonBurned', 'Fuel Carbon Burned'),
		(datatableId, 6, 'calcFuelCarbonBurned', 'Calculated Fuel Carbon Burned');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HRLYOP', 'SELECT * FROM {SCHEMA}.rpt_em_hourly_op($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'beginDate', 'Begin Date'),
		(datatableId, 3, 'beginHour', 'Begin Hour'),
		(datatableId, 4, 'opTime', 'Operating Time'),
		(datatableId, 5, 'hrLoad', 'Hour Load'),
		(datatableId, 6, 'loadRange', 'Load Range'),
	 	(datatableId, 7, 'commonStackLoadRange', 'Common Stack Load Range'),
		(datatableId, 8, 'fcFactor', 'FC Factor'),
		(datatableId, 9, 'fdFactor', 'FD Factor'),
		(datatableId, 10, 'fwFactor', 'FW Factor'),
		(datatableId, 11, 'fuelCd', 'Fuel Code'),
		(datatableId, 12, 'multiFuelFlg', 'Multi Fuel Flag'),
		(datatableId, 13, 'mhhiIndiciator', 'MHHI Inidcator'),
		(datatableId, 14, 'matsLoad', 'Mats Load'),
		(datatableId, 15, 'matsStartupShutdownFlg', 'Mats Startup Shutdown Flag'),
		(datatableId, 16, 'loadUomCode', 'Load Units of Measure Code'),
		(datatableId, 17, 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 18, 'fuelCode', 'Fuel Code');

		


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONITORHRLY', 'SELECT * FROM {SCHEMA}.rpt_em_monitor_hourly_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 4, 'applicableBiasAdjFactor', 'Applicable Bias Adjusted Factor'),
		(datatableId, 5, 'unadjustedHourlyValue', 'Unadjusted Hourly Value'),
		(datatableId, 6, 'adjustedHourlyValue', 'Adjusted Hourly Value'),
	 	(datatableId, 7, 'calcAdjustedHourlyValue', 'Calculated Adjusted Hourly Value'),
		(datatableId, 8, 'pctAvailable', 'Percent Available'),
		(datatableId, 9, 'moistureBasis', 'Moisture Basis '),
		(datatableId, 10, 'calcLineStatus', 'Calculated Line Status'),
		(datatableId, 11, 'calcRataStatus', 'Calculated Rata Status'),
		(datatableId, 12, 'calcDaycalStatus', 'Calculated Daycal Status'),
		(datatableId, 13, 'calcLeakStatus', 'Calculated Leak Status'),
		(datatableId, 14, 'calcDayintStatus', 'Calculated Dayint Status'),
		(datatableId, 15, 'calcf21Status', 'Calculated f21 Status'),
		(datatableId, 16, 'modcCode', 'Method of Determination Code'),
		(datatableId, 17, 'parameterCode', 'Parameter Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MATSMONHRLY', 'SELECT * FROM {SCHEMA}.rpt_em_mats_monitor_hourly_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 4, 'unadjustedHourlyValue', 'Unadjusted Hourly Value'),
		(datatableId, 5, 'pctAvailable', 'Percent Available'),
		(datatableId, 6, 'calcUnadjustedHourlyValue', 'Calculated Unadjusted Hourly Value '),
		(datatableId, 7, 'calcDailyCalStatus', 'Calculated DailyCal Status'),
		(datatableId, 8, 'calcHgLineStatus', 'Calculated Hg Line  Status'),
		(datatableId, 9, 'calcHgi1Status', 'Calculated Hgi1 Status'),
		(datatableId, 10, 'calcRataStatus', 'Calculated Rata Status'),
		(datatableId, 11, 'modcCode', 'Method of Determination Code'),
		(datatableId, 12, 'parameterCode', 'Parameter Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DERHRLY', 'SELECT * FROM {SCHEMA}.rpt_em_derived_hourly_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'formulaIdentifier', 'Formula Identifier'),
		(datatableId, 4, 'applicableBiasAdjFactor', 'Applicable Bias Adjusted Factor'),
		(datatableId, 5, 'unadjustedHourlyValue', 'Unadjusted Hourly Value'),
		(datatableId, 6, 'calcUnadjustedHourlyValue', 'Calculated Unadjusted Hourly Value '),
		(datatableId, 7, 'adjustedHourlyValue', 'Adjusted Hourly Value'),
		(datatableId, 8, 'calcAdjustedHourlyValue', 'Calculated Adjusted Hourly Valu'),
		(datatableId, 9, 'pctAvailable', 'Percent Available'),
		(datatableId, 10, 'diluentCapInd', 'Diluent Cap Indicator'),
		(datatableId, 11, 'segmentNum', 'Segment Num'),
		(datatableId, 13, 'calcPctDiluent', 'Calculated Percent Diluent'),
		(datatableId, 14, 'calcPctMoisture', 'Calculated Percent Moisture'),
		(datatableId, 15, 'calcRataStatus', 'Calculated Rata Status'),
		(datatableId, 16, 'calcAppeStatus', 'Calculated Appe Status'),
		(datatableId, 17, 'calcFuelFlowTotal', 'Calculated Fuel Flow Total'),
		(datatableId, 18, 'modcCode', 'Method of Determination Code'),
		(datatableId, 19, 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 20, 'parameterCode', 'Parameter Code'),
		(datatableId, 21, 'fuelCode', 'Fuel Code'),
		(datatableId, 22, 'calcHourMeasureCode', 'Calculated Hour Measure Code');



	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MATSDERHRLY', 'SELECT * FROM {SCHEMA}.rpt_em_mats_derived_hourly_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'formulaIdentifier', 'Formula Identifier'),
		(datatableId, 3, 'unadjustedHourlyValue', 'Unadjusted Hourly Value'),
		(datatableId, 4, 'calcUnadjustedHourlyValue', 'Calculated Unadjusted Hourly Value '),
		(datatableId, 5, 'calcPctDiluent', 'Calculated Percent Diluent'),
		(datatableId, 6, 'calcPctMoisture', 'Calculated Percent Moisture'),
		(datatableId, 7, 'modcCode', 'Method of Determination Code'),
		(datatableId, 8, 'parameterCode', 'Parameter Code');



	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HRLYFUEL', 'SELECT * FROM {SCHEMA}.rpt_em_hrly_fuel_flow($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'fuelUsageTime', 'Fuel Usage Time'),
		(datatableId, 4, 'volumetricFlowRate', 'Volumetric Flow Rate '),
		(datatableId, 5, 'massFlowRate', 'Mass Flow Rate'),
		(datatableId, 6, 'calcVolumetricFlowRate', 'Calculated Volumetric Flow Rate'),
		(datatableId, 7, 'calcAppdStatus', 'Calculated Appd Status'),
		(datatableId, 8, 'sodMassCode', 'Source of Mass Flow Rate Code'),		
		(datatableId, 9, 'sodVolumetricCode', 'Source of Volumetric Flow Rate Code'),
		(datatableId, 10, 'volumetricUomCode', 'Volumetric Units of Measure Code'),
		(datatableId, 11, 'fuelCode', 'Fuel Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HRLYPARAMFUEL', 'SELECT * FROM {SCHEMA}.rpt_em_hourly_parameter_fuel_flow($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'systemIdentifier', 'System Identifier'),
		(datatableId, 3, 'formulaIdentifier', 'Formula Identifier'),
		(datatableId, 4, 'paramValFuel', 'Parameter Value Fuel '),
		(datatableId, 5, 'calcParamValFuel', 'Calculated Parameter Value Fuel'),
		(datatableId, 6, 'segmentNum', 'Segment Number'),
		(datatableId, 7, 'calcAppeStatus', 'Calculated Appe Status'),
		(datatableId, 8, 'parameterCode', 'Parameter Code'),		
		(datatableId, 9, 'sampleTypeCode', 'Sample Type Code'),
		(datatableId, 10, 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 11, 'parameterUomCode', 'Parameter Unit of Measure Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HRLYGFM', 'SELECT * FROM {SCHEMA}.rpt_em_hourly_gas_flow_meter($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 3, 'beginEndHourFlg', 'Begin End Hour Flag'),
		(datatableId, 4, 'gfmReading', 'GFM Reading '),
		(datatableId, 5, 'avgSamplingRate', 'Average Sampling Rate'),
		(datatableId, 6, 'flowToSamplingRatio', 'Flow to Sampling Ratio'),
		(datatableId, 7, 'calcFlowToSamplingRatio', 'Calculated Flow to Sampling Ratio'),
		(datatableId, 8, 'calcFlowToSamplingMult', 'Calcualted Flow to Sampling Multiple'),		
		(datatableId, 9, 'samplingRateUomCode', 'Sampling Rate Unit of Measure Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'SORBTRAP', 'SELECT * FROM {SCHEMA}.rpt_em_sorbent_trap($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'beginDate', 'Begin Date'),
		(datatableId, 3, 'beginHour', 'Begin Hour'),
		(datatableId, 4, 'endDate', 'End Date '),
		(datatableId, 5, 'endHour', 'End Hour'),
		(datatableId, 6, 'systemIdentifier', 'System Identifier'),
		(datatableId, 7, 'pairedTrapAgreement', 'Paired Trap Agreement'),
		(datatableId, 8, 'absoluteDifferenceInd', 'Absolute Difference Indicator'),		
		(datatableId, 9, 'hgConcentration', 'Hg Concetration'),
		(datatableId, 10, 'calcPairedTrapAgreement', 'Calculated Paired Trap Agreement'),		
		(datatableId, 11, 'calcHgConcentration', 'Calcualted Hg Concentration'),		
		(datatableId, 12, 'rataInd', 'Rata Indicator'),		
		(datatableId, 13, 'modcCode', 'Modc Code'),		
		(datatableId, 14, 'calcModcCode', 'Calculated Modc Code'),		
		(datatableId, 15, 'sorbentTrapApsCode', 'Sorbent Trap APS Code');		

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'SAMPTRAIN', 'SELECT * FROM {SCHEMA}.rpt_em_sampling_train($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'componentIdentifier', 'Component Identifier'),
		(datatableId, 3, 'sorbentTrapSerialNumber', 'Sorbent Trap Serial Number'),
		(datatableId, 4, 'breakthroughTrapHg', 'Breakthrough Trap Hg'),
		(datatableId, 5, 'spikeTrapHg', 'Spike Trap Hg'),
		(datatableId, 6, 'spikeRefValue', 'Spike Reference Value'),
		(datatableId, 7, 'totalSampleVolume', 'Total Sample Value'),
		(datatableId, 8, 'refFlowToSamplingRatio', 'Reference Flow to Sampling Ratio'),		
		(datatableId, 9, 'hgConcentration', 'Hg Concetration'),
		(datatableId, 10, 'percentBreakthrough', 'Percent Breakthrough'),		
		(datatableId, 11, 'percentSpikeRecovery', 'Percent Spike Recovery'),		
		(datatableId, 12, 'sampleDamageExplanation', 'Sample Damage Explanation'),		
		(datatableId, 13, 'calcHgConcentration', 'Calculated Hg Concentration'),		
		(datatableId, 14, 'calcPercentBreakthrough', 'Calculated Percent Breakthrough'),		
		(datatableId, 15, 'samplingRatioTestResultCode', 'Sampling Ratio Test Result Code'),	
		(datatableId, 16, 'postLeakTestResultCode', 'Post Leak Test Result Code'),	
		(datatableId, 17, 'trainQaStatusCode', 'Train QA Status Code');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'NSPS4TCOMP', 'SELECT * FROM {SCHEMA}.rpt_em_nsps4t_compliance_period($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'beginYear', 'Begin Year'),
		(datatableId, 3, 'beginMonth', 'Begin Month'),
		(datatableId, 4, 'endYear', 'End Year'),
		(datatableId, 5, 'endMonth', 'End Month'),
		(datatableId, 6, 'avgCo2EmissionRate', 'Average CO2 Emission Rate'),		
		(datatableId, 7, 'pctValidOpHours', 'Percent Valid Operating Hours'),
		(datatableId, 8, 'co2ViolationInd', 'CO2 Violation Indicator'),
		(datatableId, 9, 'co2ViolationComment', 'CO2 Violation Comment'),
		(datatableId, 10, 'co2EmissionRateUomCode', 'CO2 Emission Rate Units of Measure Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'NSPS4TANNU', 'SELECT * FROM {SCHEMA}.rpt_em_nsps4t_fourth_quarter($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'annualEnergySold', 'Annual Energy Sold'),
		(datatableId, 3, 'annualPotentialOutput', 'Annual Potential Output'),
		(datatableId, 4, 'annualEnergySoldTypeCode', 'Annual Energy Sold Type Code');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
END $$;
