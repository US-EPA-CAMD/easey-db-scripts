-- verify that the exact 43-column target inventory is integer.

BEGIN;

CREATE TEMP TABLE ticket_7307_targets (
    table_schema text NOT NULL,
    table_name text NOT NULL,
    column_name text NOT NULL,
    PRIMARY KEY (table_schema, table_name, column_name)
) ON COMMIT DROP;

INSERT INTO ticket_7307_targets (table_schema, table_name, column_name)
SELECT table_schema, table_name, column_name
  FROM (VALUES
    ('camd', 'generator', 'fac_id'),
    ('camd', 'plant', 'fac_id'),
    ('camd', 'plant_person', 'fac_id'),
    ('camd', 'program', 'prg_id'),
    ('camd', 'program_phase', 'prg_id'),
    ('camd', 'unit', 'fac_id'),
    ('camd', 'unit', 'unit_id'),
    ('camd', 'unit_boiler_type', 'unit_id'),
    ('camd', 'unit_exemption', 'unit_id'),
    ('camd', 'unit_generator', 'unit_id'),
    ('camd', 'unit_op_status', 'unit_id'),
    ('camd', 'unit_program', 'prg_id'),
    ('camd', 'unit_program', 'unit_id'),
    ('camdaux', 'inventory_status_log', 'fac_id'),
    ('camdaux', 'inventory_status_log', 'unit_id'),
    ('camdecmps', 'daily_backstop', 'unit_id'),
    ('camdecmps', 'dm_emissions', 'fac_id'),
    ('camdecmps', 'monitor_location', 'unit_id'),
    ('camdecmps', 'monitor_plan', 'fac_id'),
    ('camdecmps', 'stack_pipe', 'fac_id'),
    ('camdecmps', 'unit_capacity', 'unit_id'),
    ('camdecmps', 'unit_control', 'unit_id'),
    ('camdecmps', 'unit_fuel', 'unit_id'),
    ('camdecmps', 'unit_stack_configuration', 'unit_id'),
    ('camdecmpsaux', 'email_to_process', 'fac_id'),
    ('camdecmpsaux', 'es_spec', 'fac_id'),
    ('camdecmpsaux', 'evaluation_set', 'fac_id'),
    ('camdecmpsaux', 'mats_data_submission', 'fac_id'),
    ('camdecmpsaux', 'pdem_mats_unit_hour', 'unit_id'),
    ('camdecmpsaux', 'pdem_p75_unit_hour', 'unit_id'),
    ('camdecmpsaux', 'program_parameter', 'prg_id'),
    ('camdecmpsaux', 'submission_set', 'fac_id'),
    ('camdecmpswks', 'daily_backstop', 'unit_id'),
    ('camdecmpswks', 'mats_bulk_file', 'fac_id'),
    ('camdecmpswks', 'monitor_location', 'unit_id'),
    ('camdecmpswks', 'monitor_plan', 'fac_id'),
    ('camdecmpswks', 'stack_pipe', 'fac_id'),
    ('camdecmpswks', 'unit', 'fac_id'),
    ('camdecmpswks', 'unit', 'unit_id'),
    ('camdecmpswks', 'unit_capacity', 'unit_id'),
    ('camdecmpswks', 'unit_control', 'unit_id'),
    ('camdecmpswks', 'unit_fuel', 'unit_id'),
    ('camdecmpswks', 'unit_stack_configuration', 'unit_id')
  ) AS targets(table_schema, table_name, column_name);

DO $postflight$
DECLARE
    invalid_columns text;
BEGIN
    IF (SELECT count(*) FROM ticket_7307_targets) <> 43 THEN
        RAISE EXCEPTION 'Ticket #7307 target inventory must contain exactly 43 columns';
    END IF;

    SELECT string_agg(
               format(
                   '%I.%I.%I is %s',
                   targets.table_schema,
                   targets.table_name,
                   targets.column_name,
                   COALESCE(columns.data_type, 'missing')
               ),
               E'\n'
           )
      INTO invalid_columns
      FROM ticket_7307_targets targets
      LEFT JOIN information_schema.columns columns
        ON columns.table_schema = targets.table_schema
       AND columns.table_name = targets.table_name
       AND columns.column_name = targets.column_name
     WHERE columns.data_type IS DISTINCT FROM 'integer';

    IF invalid_columns IS NOT NULL THEN
        RAISE EXCEPTION
            'Ticket #7307 postflight requires all 43 targets to be integer:%',
            E'\n' || invalid_columns;
    END IF;
END
$postflight$;

ROLLBACK;
