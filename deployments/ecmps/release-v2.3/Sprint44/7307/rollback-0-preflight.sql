-- This script makes no persistent changes. It must complete successfully before
-- dropping camdsnap materialized views

BEGIN;

CREATE TEMP TABLE rollback_7307_targets (
    table_schema text NOT NULL,
    table_name text NOT NULL,
    column_name text NOT NULL,
    PRIMARY KEY (table_schema, table_name, column_name)
) ON COMMIT DROP;

INSERT INTO rollback_7307_targets (table_schema, table_name, column_name) VALUES
    ('camd', 'generator', 'fac_id'),
    ('camd', 'generator', 'gen_id'),
    ('camd', 'plant', 'fac_id'),
    ('camd', 'plant_person', 'fac_id'),
    ('camd', 'plant_person', 'fac_ppl_id'),
    ('camd', 'plant_person', 'ppl_id'),
    ('camd', 'program', 'prg_id'),
    ('camd', 'program_phase', 'prg_id'),
    ('camd', 'program_phase', 'program_phase_id'),
    ('camd', 'unit', 'fac_id'),
    ('camd', 'unit', 'unit_id'),
    ('camd', 'unit_boiler_type', 'unit_boiler_type_id'),
    ('camd', 'unit_boiler_type', 'unit_id'),
    ('camd', 'unit_exemption', 'submitter_ppl_id'),
    ('camd', 'unit_exemption', 'unit_exempt_id'),
    ('camd', 'unit_exemption', 'unit_id'),
    ('camd', 'unit_generator', 'gen_id'),
    ('camd', 'unit_generator', 'unit_gen_id'),
    ('camd', 'unit_generator', 'unit_id'),
    ('camd', 'unit_op_status', 'unit_id'),
    ('camd', 'unit_op_status', 'unit_op_status_id'),
    ('camd', 'unit_program', 'prg_id'),
    ('camd', 'unit_program', 'unit_id'),
    ('camd', 'unit_program', 'up_id'),
    ('camdaux', 'inventory_status_log', 'fac_id'),
    ('camdaux', 'inventory_status_log', 'unit_id'),
    ('camdecmps', 'daily_backstop', 'unit_id'),
    ('camdecmps', 'dm_emissions', 'fac_id'),
    ('camdecmps', 'emission_evaluation', 'submission_id'),
    ('camdecmps', 'monitor_location', 'unit_id'),
    ('camdecmps', 'monitor_plan', 'fac_id'),
    ('camdecmps', 'monitor_plan', 'submission_id'),
    ('camdecmps', 'qa_cert_event', 'submission_id'),
    ('camdecmps', 'qa_supp_data', 'submission_id'),
    ('camdecmps', 'stack_pipe', 'fac_id'),
    ('camdecmps', 'test_extension_exemption', 'submission_id'),
    ('camdecmps', 'unit_capacity', 'unit_id'),
    ('camdecmps', 'unit_control', 'unit_id'),
    ('camdecmps', 'unit_fuel', 'unit_id'),
    ('camdecmps', 'unit_stack_configuration', 'unit_id'),
    ('camdecmpsaux', 'apportionment', 'apport_id'),
    ('camdecmpsaux', 'apportionment_data', 'apport_data_id'),
    ('camdecmpsaux', 'apportionment_data', 'apport_range_id'),
    ('camdecmpsaux', 'apportionment_range', 'apport_id'),
    ('camdecmpsaux', 'apportionment_range', 'apport_range_id'),
    ('camdecmpsaux', 'check_log', 'check_catalog_result_id'),
    ('camdecmpsaux', 'check_log', 'error_suppress_id'),
    ('camdecmpsaux', 'check_log', 'rule_check_id'),
    ('camdecmpsaux', 'email_to_process', 'fac_id'),
    ('camdecmpsaux', 'es_spec', 'check_catalog_result_id'),
    ('camdecmpsaux', 'es_spec', 'fac_id'),
    ('camdecmpsaux', 'evaluation_set', 'fac_id'),
    ('camdecmpsaux', 'mats_data_submission', 'fac_id'),
    ('camdecmpsaux', 'pdem_mats_unit_hour', 'unit_id'),
    ('camdecmpsaux', 'pdem_p75_unit_hour', 'unit_id'),
    ('camdecmpsaux', 'program_parameter', 'prg_id'),
    ('camdecmpsaux', 'program_parameter', 'prg_param_id'),
    ('camdecmpsaux', 'submission_set', 'fac_id'),
    ('camdecmpsmd', 'check_catalog', 'check_catalog_id'),
    ('camdecmpsmd', 'check_catalog_process', 'check_catalog_id'),
    ('camdecmpsmd', 'check_catalog_result', 'check_catalog_id'),
    ('camdecmpsmd', 'check_catalog_result', 'check_catalog_result_id'),
    ('camdecmpsmd', 'check_catalog_result', 'response_catalog_id'),
    ('camdecmpsmd', 'earliest_partition_quarter', 'earliest_partition_quarter_id'),
    ('camdecmpsmd', 'parameter_uom', 'param_id'),
    ('camdecmpsmd', 'rule_check', 'check_catalog_id'),
    ('camdecmpsmd', 'rule_check', 'rule_check_id'),
    ('camdecmpswks', 'check_log', 'check_catalog_result_id'),
    ('camdecmpswks', 'check_log', 'error_suppress_id'),
    ('camdecmpswks', 'check_log', 'rule_check_id'),
    ('camdecmpswks', 'daily_backstop', 'unit_id'),
    ('camdecmpswks', 'emission_evaluation', 'submission_id'),
    ('camdecmpswks', 'mats_bulk_file', 'fac_id'),
    ('camdecmpswks', 'mats_bulk_file', 'submission_id'),
    ('camdecmpswks', 'monitor_location', 'unit_id'),
    ('camdecmpswks', 'monitor_plan', 'fac_id'),
    ('camdecmpswks', 'monitor_plan', 'submission_id'),
    ('camdecmpswks', 'qa_cert_event', 'submission_id'),
    ('camdecmpswks', 'qa_supp_data', 'submission_id'),
    ('camdecmpswks', 'stack_pipe', 'fac_id'),
    ('camdecmpswks', 'test_extension_exemption', 'submission_id'),
    ('camdecmpswks', 'unit', 'fac_id'),
    ('camdecmpswks', 'unit', 'unit_id'),
    ('camdecmpswks', 'unit_capacity', 'unit_id'),
    ('camdecmpswks', 'unit_control', 'unit_id'),
    ('camdecmpswks', 'unit_fuel', 'unit_id'),
    ('camdecmpswks', 'unit_stack_configuration', 'unit_id');

DO $preflight$
DECLARE
    unexpected_columns text;
    identity_columns text;
BEGIN
    IF (SELECT count(*) FROM rollback_7307_targets) <> 87 THEN
        RAISE EXCEPTION 'Ticket #7307 rollback target inventory must contain exactly 87 columns';
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
      INTO unexpected_columns
      FROM rollback_7307_targets targets
      LEFT JOIN information_schema.columns columns
        ON columns.table_schema = targets.table_schema
       AND columns.table_name = targets.table_name
       AND columns.column_name = targets.column_name
     WHERE columns.data_type IS DISTINCT FROM 'bigint';

    IF unexpected_columns IS NOT NULL THEN
        RAISE EXCEPTION
            'Ticket #7307 rollback requires all 87 targets to be bigint:%',
            E'\n' || unexpected_columns;
    END IF;

    SELECT string_agg(
               format('%I.%I.%I', targets.table_schema, targets.table_name, targets.column_name),
               E'\n'
           )
      INTO identity_columns
      FROM rollback_7307_targets targets
      JOIN pg_namespace namespaces
        ON namespaces.nspname = targets.table_schema
      JOIN pg_class tables
        ON tables.relnamespace = namespaces.oid
       AND tables.relname = targets.table_name
      JOIN pg_attribute attributes
        ON attributes.attrelid = tables.oid
       AND attributes.attname = targets.column_name
     WHERE attributes.attidentity <> '';

    IF identity_columns IS NOT NULL THEN
        RAISE EXCEPTION
            'Cannot restore identity columns to numeric(38,0). Remove identity definitions explicitly before retrying:%',
            E'\n' || identity_columns;
    END IF;
END
$preflight$;

ROLLBACK;
