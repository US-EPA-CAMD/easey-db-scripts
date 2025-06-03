DO $$
DECLARE
	groupCode text := 'MDM';
	datasetCode text;
	datatableId integer;
BEGIN
  datasetCode := 'reporting-frequency-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'Report Frequency Codes & Descriptions');

    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'Report Frequency Codes & Descriptions', 'SELECT * FROM camdecmpsmd.report_freq_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'report_freq_cd', 'reportFrequencyCode', 'Report Frequency Code'),
        (datatableId, 2, 'report_freq_cd_description', 'reportFrequencyCodeDescription', 'Report Frequency Code Descriptions');
---------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'operating-type-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'Operating Type Codes & Descriptions');

    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'Operating Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.operating_type_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'op_type_cd', 'operatingTypeCode', 'Operating Type Code'),
        (datatableId, 2, 'op_type_cd_description', 'operatingTypeCodeDescription', 'Operating Type Code Description');
--------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'file-type-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'File Type Codes & Descriptions');

    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'File Type Codes & Descriptions', 'SELECT * FROM camdecmpsmd.file_type_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'file_type_cd', 'fileTypeCode', 'File Type Code'),
        (datatableId, 2, 'file_type_cd_description', 'fileTypeCodeDescription', 'File Type Code Description');
END $$;
