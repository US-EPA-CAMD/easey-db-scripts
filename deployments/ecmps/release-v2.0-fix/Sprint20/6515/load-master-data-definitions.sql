DO $$
DECLARE
	groupCode text := 'MDM';
	datasetCode text;
    datasetCodes text[];
	datatableId integer;
BEGIN
    datasetCodes := ARRAY['mats-pollutant-codes', 'mats-test-method-codes', 'mats-averaging-group-codes'];

	DELETE FROM camdaux.dataset WHERE group_cd = groupCode AND dataset_cd = ANY (datasetCodes);
    WITH deletedRows AS (
        DELETE FROM camdaux.datatable 
        WHERE dataset_cd = ANY (datasetCodes) 
        RETURNING datatable_id
    )
    DELETE FROM camdaux.datacolumn 
    WHERE datatable_id IN (SELECT datatable_id FROM deletedRows);
----------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'mats-pollutant-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'MATS Pollutant Codes & Descriptions');
    
    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'MATS Pollutant Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_pollutant_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'mats_pollutant_cd', 'matsPollutantCode', 'MATS Pollutant Code'),
        (datatableId, 2, 'mats_pollutant_description', 'matsPollutantDescription', 'MATS Pollutant Description');
----------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'mats-test-method-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'MATS Test Method Codes & Descriptions');

    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'MATS Test Method Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_test_method_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'mats_test_meth_cd', 'matsTestMethodCode', 'MATS Test Method Code'),
        (datatableId, 2, 'mats_test_meth_description', 'matsTestMethodDescription', 'MATS Test Method Description');
----------------------------------------------------------------------------------------------------------------------------
    datasetCode := 'mats-averaging-group-codes';
    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES (datasetCode, groupCode, 'MATS Averaging Group Codes & Descriptions');

    /***** DATATABLE 1 *****/
    INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
    VALUES (datasetCode, 1, 'MATS Averaging Group Codes & Descriptions', 'SELECT * FROM camdecmpsmd.mats_averaging_group_code')
    RETURNING datatable_id INTO datatableId;

    /***** COLUMNS *****/
    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
    VALUES
        (datatableId, 1, 'mats_avg_group_cd', 'matsAveragingGroupCode', 'MATS Averaging Group Code'),
        (datatableId, 2, 'mats_avg_group_description', 'matsAveragingGroupDescription', 'MATS Averaging Group Description');

    COMMIT;
END $$;

