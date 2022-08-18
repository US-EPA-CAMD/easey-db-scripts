DO $$
DECLARE
	reportType text := 'MP';
	reportId integer;
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES(reportType, 'Monitoring Plan Printout Report', 'There is no data for the specified monitor Plan')
	RETURNING report_id INTO reportId;

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES(reportId, 1, 'Reporting Frequency', 'SELECT * FROM camdecmpswks.rpt_mp_reporting_frequency($1)', null)
	RETURNING report_detail_id INTO detailId;
		
	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(2, 'frequency', 'Frequency', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(3, 'beginQuarter', 'Begin Quarter', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(4, 'endQuarter', 'End Quarter', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);

------------------------------------------------------------------------------------------------
	/***** REPORT DETAIL 2 *****/
	INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES(reportId, 2, 'Location Attributes', 'SELECT * FROM camdecmpswks.rpt_mp_location_attribute($1)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(2, 'ductIndicator', 'Duct Indicator', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(3, 'groundElevation', 'Ground Elevation', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(4, 'stackHeight', 'Stack Height', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(5, 'crossAreaExit', 'Cross Area Exit', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(6, 'crossAreaFlow', 'Cross Area Flow', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(7, 'materialCode', 'Material Code', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(8, 'shapeCode', 'Shape Code', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(9, 'beginDate', 'Begin Date', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(10, 'endDate', 'End Date', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
END $$;