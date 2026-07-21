-- Report definition for the per-file bulk import results/errors report, rendered
-- by the ecmps-ui ReportGenerator (reportCode = BULK_IMPORT, parameter importId).
-- Requires camdecmpsaux.rpt_bulk_import_results (camdecmpsaux/functions).

DO $do$
DECLARE
    datatableId integer;
BEGIN
    DELETE FROM camdaux.dataset WHERE dataset_cd = 'BULK_IMPORT';

    INSERT INTO camdaux.template_code(template_cd, group_cd, template_type, display_name)
    VALUES ('BULKIMPORT', 'BULK_IMPORT', 'DEFAULT', 'Bulk Import Results')
    ON CONFLICT (template_cd) DO NOTHING;

    INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
    VALUES ('BULK_IMPORT', 'REPORT', 'Bulk Import Results Report');

    INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
    VALUES ('BULK_IMPORT', 1, 'BULKIMPORT', 'SELECT * FROM camdecmpsaux.rpt_bulk_import_results($1)')
    RETURNING datatable_id INTO datatableId;

    INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
    VALUES
        (datatableId, 1, 'fileName', 'File Name'),
        (datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
        (datatableId, 3, 'fileType', 'Type'),
        (datatableId, 4, 'reportingPeriod', 'Reporting Period'),
        (datatableId, 5, 'status', 'Status'),
        (datatableId, 6, 'note', 'Errors');

    INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
    VALUES (datatableId, 1, 'importId', null);
END $do$;
