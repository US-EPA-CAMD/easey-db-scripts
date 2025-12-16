
-------------------------------------------------------------------------------
-- STEP 1: Add Template Code for Unit Controls

INSERT INTO camdaux.template_code (
    template_cd,
    group_cd,
    template_type,
    display_name,
    sort_order
) VALUES (
    'UNITCONTROLS',
    'ALL',
    'DATA',
    'Unit Controls',
    NULL
);

-------------------------------------------------------------------------------
-- STEP 2: Add DataTable for Unit Controls Section

INSERT INTO camdaux.datatable (
    dataset_cd,
    template_cd,
    table_order,
    display_name,
    sql_statement,
    no_results_msg_override
) VALUES (
    'MPP',
    'UNITCONTROLS',

    (SELECT COALESCE(MAX(table_order), 0) + 1 FROM camdaux.datatable WHERE dataset_cd = 'MPP'),
    'Unit Controls',
    'SELECT
        u.unitid AS unit_name,
        uc.ce_param AS parameter_code,
        uc.control_cd AS control_code,
        CASE WHEN uc.orig_cd = ''1'' THEN ''Original''
             WHEN uc.orig_cd = ''0'' THEN ''Retrofit''
             ELSE uc.orig_cd
        END AS original_retrofit,
        TO_CHAR(uc.install_date, ''MM/DD/YYYY'') AS install_date,
        TO_CHAR(uc.opt_date, ''MM/DD/YYYY'') AS optimization_date,
        CASE WHEN uc.seas_cd = ''1'' THEN ''Yes''
             WHEN uc.seas_cd = ''0'' THEN ''No''
             ELSE uc.seas_cd
        END AS seasonal_controls,
        TO_CHAR(uc.retire_date, ''MM/DD/YYYY'') AS retire_date,
        CASE WHEN uc.retire_date IS NULL THEN ''Active''
             ELSE ''Inactive''
        END AS status
    FROM {SCHEMA}.unit_control uc
    JOIN {SCHEMA}.unit u ON u.unit_id = uc.unit_id
    JOIN {SCHEMA}.monitor_location ml ON ml.unit_id = u.unit_id
    JOIN {SCHEMA}.monitor_plan_location mpl ON mpl.mon_loc_id = ml.mon_loc_id
    WHERE mpl.mon_plan_id = $1
    ORDER BY u.unitid, uc.ce_param, uc.install_date',
    'No unit control equipment is associated with this monitoring plan.'
);

-------------------------------------------------------------------------------
-- STEP 3: Add DataColumns for Unit Controls Section

DO $$
DECLARE
    unit_controls_table_id INTEGER;
BEGIN
    SELECT datatable_id INTO unit_controls_table_id
    FROM camdaux.datatable
    WHERE dataset_cd = 'MPP' AND template_cd = 'UNITCONTROLS';

    -- Insert column definitions
    INSERT INTO camdaux.datacolumn (
        datatable_id,
        column_order,
        name,
        alias,
        display_name
    ) VALUES
        (unit_controls_table_id, 1, 'unit_name', NULL, 'Unit'),
        (unit_controls_table_id, 2, 'parameter_code', NULL, 'Parameter'),
        (unit_controls_table_id, 3, 'control_code', NULL, 'Control Code'),
        (unit_controls_table_id, 4, 'original_retrofit', NULL, 'Original/Retrofit'),
        (unit_controls_table_id, 5, 'install_date', NULL, 'Install Date'),
        (unit_controls_table_id, 6, 'optimization_date', NULL, 'Optimization Date'),
        (unit_controls_table_id, 7, 'seasonal_controls', NULL, 'Seasonal Controls'),
        (unit_controls_table_id, 8, 'retire_date', NULL, 'Retire Date'),
        (unit_controls_table_id, 9, 'status', NULL, 'Status');
END $$;

-------------------------------------------------------------------------------
-- STEP 4: Add DataParameter for Monitor Plan ID


DO $$
DECLARE
    unit_controls_table_id INTEGER;
BEGIN
    SELECT datatable_id INTO unit_controls_table_id
    FROM camdaux.datatable
    WHERE dataset_cd = 'MPP' AND template_cd = 'UNITCONTROLS';

    -- Insert parameter definition
    INSERT INTO camdaux.dataparameter (
        datatable_id,
        parameter_order,
        name,
        default_value
    ) VALUES (
        unit_controls_table_id,
        1,
        'monitorPlanId',
        NULL
    );
END $$;

-------------------------------------------------------------------------------