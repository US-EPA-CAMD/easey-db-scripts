DO $$
DECLARE
datasetCode text := 'EM_QRT_SUM';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
VALUES(datasetCode, groupCode, 'Cumulative Data Summary -- EPA-Accepted Values', 'Cumulative Data Summary does not exist for the specified monitor plan and reporting period.');
------------------------------------------------------------------------------------------------
tableOrder := tableOrder + 1;
INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM {SCHEMA}.rpt_em_emission_view_summary($1, $2, $3)')
    RETURNING datatable_id INTO datatableId;

/***** COLUMNS *****/
INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
VALUES
    (datatableId, 1, 'period_description', 'periodDescription', 'Reporting Period'),
    (datatableId, 2, 'row_name', 'rowName', 'Value'),
    (datatableId, 3, 'op_hours', 'opHours', '# of Op. Hours'),
    (datatableId, 4, 'op_time', 'opTime', 'Op. Time (hrs)'),
    (datatableId, 5, 'heat_input', 'heatInput', 'Heat Input (mmBtu)'),
    (datatableId, 6, 'so2_mass', 'so2Mass', 'SO2 Mass (tons)'),
    (datatableId, 7, 'co2_mass', 'co2Mass', 'CO2 Mass (tons)'),
    (datatableId, 8, 'nox_rate', 'noxRate', 'NOx Rate (lb/mmBtu)'),
    (datatableId, 9, 'nox_mass', 'noxMass', 'NOx Mass (tons)');

/***** PARAMETERS *****/
INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
VALUES
    (datatableId, 1, 'monitorPlanId', null),
    (datatableId, 2, 'locationId', null),
    (datatableId, 3, 'reportingPeriodIds', null);
------------------------------------------------------------------------------------------------
END $$;
