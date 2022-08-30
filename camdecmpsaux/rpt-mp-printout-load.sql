DO $$
DECLARE
	reportCode text := 'MPP';
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_cd, report_title, report_template_cd, no_results_msg)
	VALUES(reportCode, 'Monitoring Plan Printout Report', 'SUMMARY', 'There is no data for the specified monitor Plan');

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, detail_title, sql_statement, no_results_msg_override)
	VALUES(reportCode, 1, 'Reporting Frequency', 'SELECT * FROM camdecmpswks.rpt_mp_reporting_frequency($1)', null)
	RETURNING report_detail_id INTO detailId;
		
	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(2, 'frequency', 'Frequency', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(3, 'beginQuarter', 'Begin Quarter', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(4, 'endQuarter', 'End Quarter', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);

------------------------------------------------------------------------------------------------
	/***** REPORT DETAIL 2 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, detail_title, sql_statement, no_results_msg_override)
	VALUES(reportCode, 2, 'Location Attributes', 'SELECT * FROM camdecmpswks.rpt_mp_location_attribute($1)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(2, 'ductIndicator', 'Duct Indicator', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(3, 'groundElevation', 'Ground Elevation', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(4, 'stackHeight', 'Stack Height', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(5, 'crossAreaExit', 'Cross Area Exit', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(6, 'crossAreaFlow', 'Cross Area Flow', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(7, 'materialCode', 'Material Code', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(8, 'shapeCode', 'Shape Code', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(9, 'beginDate', 'Begin Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(10, 'endDate', 'End Date', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);

------------------------------------------------------------------------------------------------
	/***** REPORT DETAIL 3 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, detail_title, sql_statement, no_results_msg_override)
	VALUES(reportCode, 3, 'Unit Operation/Capacity', 'SELECT * FROM camdecmpswks.rpt_mp_unit_capacity($1)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, 'unitIdentifier', 'Unit Identifier', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(2, 'nonLoadBasedIndicator', 'Non-Load Based Ind', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(3, 'commercialOpDate', 'Commence Commercial Operation Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(4, 'commenceOpDate', 'Commence Operation Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(5, 'unitTypeCode', 'Unit Type', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(6, 'beginDate', 'Begin Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(7, 'endDate', 'End Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(8, 'maxHICapacity', 'Max Heat Input Capacity', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(9, 'capacityBeginDate', 'Capacity Begin Date', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(10, 'capacityEndDate', 'Capacity End Date', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
END $$;