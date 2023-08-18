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
	VALUES(datasetCode, tableOrder, 'SUMVAL', 'SELECT * FROM camdecmpswks.rpt_em_summary_value($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'parameterCode', 'Parameter Code'),
		(datatableId, 3, 'currentRptPeriodTotal', 'Current Reporting Period Total'),
		(datatableId, 4, 'calcCurrentRptPeriodTotal', 'Calculated Current Reporting Period Total'),
		(datatableId, 4, 'osTotal', 'OS Total'),
		(datatableId, 4, 'calcOsTotal', 'Calculated OS Total'),
		(datatableId, 4, 'yearTotal', 'Year Total'),
		(datatableId, 4, 'calcYearTotal', 'Calculated Year Total');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null),
		(datatableId, 3, 'quarter', null);
------------------------------------------------------------------------------------------------
	
END $$;
