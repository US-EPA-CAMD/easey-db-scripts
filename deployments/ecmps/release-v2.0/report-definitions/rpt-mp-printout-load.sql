DO $$
DECLARE
	datasetCode text := 'MPP';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Monitoring Plan Printout Report');
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO1C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County'),
		(datatableId, 6, 'latitude', 'Latitude'),
		(datatableId, 7, 'longitude', 'Longitude');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'facilityId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RPTFREQ', 'SELECT * FROM {SCHEMA}.rpt_mp_reporting_frequency($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'reportFrequency', 'Frequency'),
		(datatableId, 3, 'beginQuarter', 'Begin Quarter'),
		(datatableId, 4, 'endQuarter', 'End Quarter');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LOCATTR', 'SELECT * FROM {SCHEMA}.rpt_mp_location_attribute($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'ductIndicator', 'Duct Indicator'),
		(datatableId, 3, 'groundElevation', 'Ground Elevation'),
		(datatableId, 4, 'stackHeight', 'Stack Height'),
		(datatableId, 5, 'crossAreaExit', 'Cross Area Exit'),
		(datatableId, 6, 'crossAreaFlow', 'Cross Area Flow'),
		(datatableId, 7, 'materialCode', 'Material Code'),
		(datatableId, 8, 'shapeCode', 'Shape Code'),
		(datatableId, 9, 'beginDate', 'Begin Date'),
		(datatableId, 10, 'endDate', 'End Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNTOPCAP', 'SELECT * FROM {SCHEMA}.rpt_mp_unit_capacity($1)')
	RETURNING datatable_id INTO datatableId;
	
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitIdentifier', 'Unit Identifier'),
		(datatableId, 2, 'nonLoadBasedIndicator', 'Non-Load Based Ind'),
		(datatableId, 3, 'commercialOpDate', 'Commence Commercial Operation Date'),
		(datatableId, 4, 'commenceOpDate', 'Commence Operation Date'),
		(datatableId, 5, 'unitTypeCode', 'Unit Type'),
		(datatableId, 6, 'unitBeginDate', 'Unit Begin Date'),
		(datatableId, 7, 'unitEndDate', 'Unit End Date'),
		(datatableId, 8, 'maxHeatInput', 'Max HI (mmBtu)'),
		(datatableId, 9, 'maxHeatInputBeginDate', 'Max HI Begin Date'),
		(datatableId, 10, 'maxHeatInputEndDate', 'Max HI End Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNTPRG', 'SELECT * FROM {SCHEMA}.rpt_mp_unit_program($1)')
	RETURNING datatable_id INTO datatableId;
	
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitIdentifier', 'Unit Identifier'),
		(datatableId, 2, 'programCode', 'Program Code'),
		(datatableId, 3, 'unitClassification', 'Unit Class'),
		(datatableId, 4, 'unitMonitorCertBeginDate', 'Unit Monitor Certification Begin Date'),
		(datatableId, 5, 'unitMonitorCertDeadline', 'Unit Monitor Certification Deadline');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNTFUEL', 'SELECT * FROM {SCHEMA}.rpt_mp_unit_fuel($1)')
	RETURNING datatable_id INTO datatableId;
	
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitIdentifier', 'Unit Identifier'),
		(datatableId, 2, 'fuelTypeCode', 'Fuel Type'),
		(datatableId, 3, 'fuelIndicator', 'Fuel Indicator'),
		(datatableId, 4, 'gcvDemMethodCode', 'Dem Method (CGV)'),
		(datatableId, 5, 'so2demMethodCode', 'Dem Method (SO2)'),
		(datatableId, 6, 'ozoneSeasonIndicator', 'Ozone Season Indicator'),
		(datatableId, 7, 'beginDate', 'Begin Date'),
		(datatableId, 8, 'endDate', 'End Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONMTHD', 'SELECT * FROM {SCHEMA}.rpt_mp_method($1)')
	RETURNING datatable_id INTO datatableId;
	
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'parameterCode', 'Parameter'),
		(datatableId, 3, 'methodCode', 'Methodology'),
		(datatableId, 4, 'substituteDataCode', 'Substitute Data Approach'),
		(datatableId, 5, 'bypassApproachCode', 'Bypass Approach'),
		(datatableId, 6, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 7, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONSYSCMP', 'SELECT * FROM {SCHEMA}.rpt_mp_system_component($1)')
	RETURNING datatable_id INTO datatableId;
			  
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'systemIdentifier', 'System Id'),
		(datatableId, 3, 'systemTypeCode', 'System Type Code'),
		(datatableId, 4, 'systemDesignation', 'System Designation'),
		(datatableId, 5, 'systemBeginDateHour', 'Begin Date/Hr'),
		(datatableId, 6, 'systemEndDateHour', 'End Date/Hr'),
		(datatableId, 7, 'componentIdentifier', 'Component Id'),
		(datatableId, 8, 'componentTypeCode', 'Component Type Code'),
		(datatableId, 9, 'acquisitionMethodCode', 'Acquisition Method Code'),
		(datatableId, 10, 'basis', 'Basis Code'),
		(datatableId, 11, 'manufacturer', 'Manufacturer'),
		(datatableId, 12, 'modelVersion', 'Model/Version'),
		(datatableId, 13, 'serialNumber', 'Serial Number'),
		(datatableId, 14, 'componentBeginDateHour', 'Begin Date/Hr'),
		(datatableId, 15, 'componentEndDateHour', 'End Date/Hr'),
		(datatableId, 16, 'hgConverterIndicator', 'Hg Converter Indicator');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'ANLYZRNG', 'SELECT * FROM {SCHEMA}.rpt_mp_analyzer_range($1)')
	RETURNING datatable_id INTO datatableId;
			  
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'componentTypeCode', 'Component Type Code'),
		(datatableId, 3, 'componentIdentifier', 'Component Id'),
		(datatableId, 4, 'analyzerRangeLevel', 'Range Level'),
		(datatableId, 5, 'dualRangeIndicator', 'Dual Range Indicator'),
		(datatableId, 6, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 7, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'SYSFUELFLW', 'SELECT * FROM {SCHEMA}.rpt_mp_system_fuel_flow($1)')
	RETURNING datatable_id INTO datatableId;
			  
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'systemIdentifier', 'System Id'),
		(datatableId, 3, 'fuelCode', 'Fuel Code'),
		(datatableId, 4, 'maxFuelFlowRate', 'Max Fuel Flow Rate'),
		(datatableId, 5, 'unitsOfMeasureCode', 'Units of Measure'),
		(datatableId, 6, 'maxRateSourceCode', 'Source Code'),
		(datatableId, 7, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 8, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONFORM', 'SELECT * FROM {SCHEMA}.rpt_mp_formula($1)')
	RETURNING datatable_id INTO datatableId;
			  
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'parameterCode', 'Parameter'),
		(datatableId, 3, 'formulaIdentifier', 'Formula Id'),
		(datatableId, 4, 'equationCode', 'Formula Code'),
		(datatableId, 5, 'equationFormula', 'Formula'),
		(datatableId, 6, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 7, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONSPAN', 'SELECT * FROM {SCHEMA}.rpt_mp_span($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'componentTypeCode', 'Component Type'),
		(datatableId, 3, 'spanScaleLevel', 'Scale'),
		(datatableId, 4, 'spanMethodCode', 'Method'),
		(datatableId, 5, 'mpcOrMpfValue', 'MPC/MPF'),
		(datatableId, 6, 'mecValue', 'MEC'),
		(datatableId, 7, 'spanValue', 'Span Value'),
		(datatableId, 8, 'fullScaleRange', 'Full-Scale Range'),
		(datatableId, 9, 'unitsOfMeasureCode', 'Units of Measure'),
		(datatableId, 10, 'scaleTransitionPoint', 'Scale Transition Point'),
		(datatableId, 11, 'defaultHighRange', 'Def. High Range Value'),
		(datatableId, 12, 'flowFullScaleRange', 'Flow Full Range (SCFH)'),
		(datatableId, 13, 'flowSpanValue', 'Flow Span Value (SCFH)'),
		(datatableId, 14, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 15, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONLOAD', 'SELECT * FROM {SCHEMA}.rpt_mp_load($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'maxLoadValue', 'Maximum Hourly Load'),
		(datatableId, 3, 'unitsOfMeasureCode', 'Units of Measure'),
		(datatableId, 4, 'upperOperatingBoundry', 'Range of Operation (Upper)'),
		(datatableId, 5, 'lowerOperatingBoundry', 'Range of Operation (Lower)'),
		(datatableId, 6, 'normalOperatingLevel', 'Designated Normal Op Level'),
		(datatableId, 7, 'secondOperatingLevel', '2nd Most Frequently Used Op Level'),
		(datatableId, 8, 'secondNormalIndicator', '2nd Normal Indicator'),
		(datatableId, 9, 'loadAnalysisDate', 'Load Analysis Date'),
		(datatableId, 10, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 11, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MONDFLT', 'SELECT * FROM {SCHEMA}.rpt_mp_default($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'parameterCode', 'Parameter'),
		(datatableId, 3, 'defaultValue', 'Value'),
		(datatableId, 4, 'unitsOfMeasureCode', 'Units of Measure'),
		(datatableId, 5, 'defaultPurposeCode', 'Purpose Code'),
		(datatableId, 6, 'fuelCode', 'Fuel Type'),
		(datatableId, 7, 'operatingConditionCode', 'Operating Condition'),
		(datatableId, 8, 'defaultSourceCode', 'Source of Value'),
		(datatableId, 9, 'beginDateHour', 'Begin Date/Hr'),
		(datatableId, 10, 'endDateHour', 'End Date/Hr');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QUALPCT', 'SELECT * FROM {SCHEMA}.rpt_mp_qualification_pct($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'qualificationTypeCode', 'Type'),
		(datatableId, 3, 'beginDate', 'Begin Date'),
		(datatableId, 4, 'endDate', 'End Date'),
		(datatableId, 5, 'qualificationYear', 'Qualification Year'),
		(datatableId, 6, 'averagePercentValue', 'Average % Value'),
		(datatableId, 7, 'year1', 'Year 1'),
		(datatableId, 8, 'year1DataTypeCode', 'Year 1 Type'),
		(datatableId, 9, 'year1PercentValue', 'Year 1 % Value'),
		(datatableId, 10, 'year2', 'Year 2'),
		(datatableId, 11, 'year2DataTypeCode', 'Year 2 Type'),
		(datatableId, 12, 'year2PercentValue', 'Year 2 % Value'),
		(datatableId, 13, 'year3', 'Year 3'),
		(datatableId, 14, 'year3DataTypeCode', 'Year 3 Type'),
		(datatableId, 15, 'year3PercentValue', 'Year 3 % Value');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QUALLME', 'SELECT * FROM {SCHEMA}.rpt_mp_qualification_lme($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'qualificationTypeCode', 'Type'),
		(datatableId, 3, 'beginDate', 'Begin Date'),
		(datatableId, 4, 'endDate', 'End Date'),
		(datatableId, 5, 'qualificationYear', 'Qualification Year'),
		(datatableId, 6, 'operatingHours', 'Operating Hours'),
		(datatableId, 7, 'so2Tons', 'SO2 Tons'),
		(datatableId, 8, 'noxTons', 'NOx  Tons');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
END $$;

/*
DO NOT KNOW ORDER OF THESE AND IF THEY SHOULD BE ON REPORT
{SCHEMA}.monitor_qualification_lee
amdecmpswks.mats_method_data
{SCHEMA}.monitor_plan_comment
{SCHEMA}.rect_duct_waf
{SCHEMA}.unit_control
*/