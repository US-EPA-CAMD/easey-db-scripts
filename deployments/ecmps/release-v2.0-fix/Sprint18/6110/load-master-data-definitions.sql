DO $$
DECLARE
	groupCode text := 'MDM';
	datasetCode text;
	datatableId integer;
BEGIN
    /***** MATS Report Type Codes & Descriptions *****/
----------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'mats-report-type-codes';

	DELETE FROM camdaux.dataset WHERE group_cd = groupCode AND dataset_cd = datasetCode;
    DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode;
    DELETE FROM camdaux.datacolumn WHERE name = ANY (ARRAY['mats_rpt_type_cd', 'mats_rpt_type_description', 'metadata_rpt_type_cd', 'requires_pollutant', 'requires_test_method']);

    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, 'MDM', 'MATS Report Type Codes & Descriptions');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'MATS Report Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_report_type_code')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'mats_rpt_type_cd', 'matsReportTypeCode', 'MATS Report Type Code'),
		(datatableId, 2, 'mats_rpt_type_description', 'matsReportTypeDescription', 'MATS Report Type Description');
END $$;

