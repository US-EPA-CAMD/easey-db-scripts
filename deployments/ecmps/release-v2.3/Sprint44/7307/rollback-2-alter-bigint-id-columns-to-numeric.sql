-- restore the 87 deployed bigint identifier columns to numeric(38,0).
-- Run after rollback-1-drop-dependent-views-and-foreign-keys.sql.

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

DO $rollback$
DECLARE
    unexpected_columns text;
    identity_columns text;
BEGIN
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
            'Ticket #7307 rollback requires all 87 targets to be bigint before execution:%',
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
$rollback$;

ALTER TABLE IF EXISTS camd.generator
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN gen_id TYPE numeric(38,0) USING gen_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.plant
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.plant_person
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN fac_ppl_id TYPE numeric(38,0) USING fac_ppl_id::numeric(38,0),
    ALTER COLUMN ppl_id TYPE numeric(38,0) USING ppl_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.program
    ALTER COLUMN prg_id TYPE numeric(38,0) USING prg_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.program_phase
    ALTER COLUMN prg_id TYPE numeric(38,0) USING prg_id::numeric(38,0),
    ALTER COLUMN program_phase_id TYPE numeric(38,0) USING program_phase_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit_boiler_type
    ALTER COLUMN unit_boiler_type_id TYPE numeric(38,0) USING unit_boiler_type_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit_exemption
    ALTER COLUMN submitter_ppl_id TYPE numeric(38,0) USING submitter_ppl_id::numeric(38,0),
    ALTER COLUMN unit_exempt_id TYPE numeric(38,0) USING unit_exempt_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit_generator
    ALTER COLUMN gen_id TYPE numeric(38,0) USING gen_id::numeric(38,0),
    ALTER COLUMN unit_gen_id TYPE numeric(38,0) USING unit_gen_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit_op_status
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0),
    ALTER COLUMN unit_op_status_id TYPE numeric(38,0) USING unit_op_status_id::numeric(38,0);
ALTER TABLE IF EXISTS camd.unit_program
    ALTER COLUMN prg_id TYPE numeric(38,0) USING prg_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0),
    ALTER COLUMN up_id TYPE numeric(38,0) USING up_id::numeric(38,0);
ALTER TABLE IF EXISTS camdaux.inventory_status_log
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);

ALTER TABLE IF EXISTS camdecmps.daily_backstop
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.dm_emissions
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.emission_evaluation
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.monitor_location
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.monitor_plan
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.qa_cert_event
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.qa_supp_data
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.stack_pipe
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.test_extension_exemption
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.unit_capacity
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.unit_control
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.unit_fuel
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);

ALTER TABLE IF EXISTS camdecmpsaux.apportionment
    ALTER COLUMN apport_id TYPE numeric(38,0) USING apport_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data
    ALTER COLUMN apport_data_id TYPE numeric(38,0) USING apport_data_id::numeric(38,0),
    ALTER COLUMN apport_range_id TYPE numeric(38,0) USING apport_range_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range
    ALTER COLUMN apport_id TYPE numeric(38,0) USING apport_id::numeric(38,0),
    ALTER COLUMN apport_range_id TYPE numeric(38,0) USING apport_range_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.check_log
    ALTER COLUMN check_catalog_result_id TYPE numeric(38,0) USING check_catalog_result_id::numeric(38,0),
    ALTER COLUMN error_suppress_id TYPE numeric(38,0) USING error_suppress_id::numeric(38,0),
    ALTER COLUMN rule_check_id TYPE numeric(38,0) USING rule_check_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.email_to_process
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
    ALTER COLUMN check_catalog_result_id TYPE numeric(38,0) USING check_catalog_result_id::numeric(38,0),
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.program_parameter
    ALTER COLUMN prg_id TYPE numeric(38,0) USING prg_id::numeric(38,0),
    ALTER COLUMN prg_param_id TYPE numeric(38,0) USING prg_param_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsaux.submission_set
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog
    ALTER COLUMN check_catalog_id TYPE numeric(38,0) USING check_catalog_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_process
    ALTER COLUMN check_catalog_id TYPE numeric(38,0) USING check_catalog_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_result
    ALTER COLUMN check_catalog_id TYPE numeric(38,0) USING check_catalog_id::numeric(38,0),
    ALTER COLUMN check_catalog_result_id TYPE numeric(38,0) USING check_catalog_result_id::numeric(38,0),
    ALTER COLUMN response_catalog_id TYPE numeric(38,0) USING response_catalog_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsmd.earliest_partition_quarter
    ALTER COLUMN earliest_partition_quarter_id TYPE numeric(38,0) USING earliest_partition_quarter_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsmd.parameter_uom
    ALTER COLUMN param_id TYPE numeric(38,0) USING param_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpsmd.rule_check
    ALTER COLUMN check_catalog_id TYPE numeric(38,0) USING check_catalog_id::numeric(38,0),
    ALTER COLUMN rule_check_id TYPE numeric(38,0) USING rule_check_id::numeric(38,0);

ALTER TABLE IF EXISTS camdecmpswks.check_log
    ALTER COLUMN check_catalog_result_id TYPE numeric(38,0) USING check_catalog_result_id::numeric(38,0),
    ALTER COLUMN error_suppress_id TYPE numeric(38,0) USING error_suppress_id::numeric(38,0),
    ALTER COLUMN rule_check_id TYPE numeric(38,0) USING rule_check_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.daily_backstop
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.monitor_location
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.qa_supp_data
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.stack_pipe
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    ALTER COLUMN submission_id TYPE numeric(38,0) USING submission_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.unit
    ALTER COLUMN fac_id TYPE numeric(38,0) USING fac_id::numeric(38,0),
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.unit_capacity
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.unit_control
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.unit_fuel
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);
ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration
    ALTER COLUMN unit_id TYPE numeric(38,0) USING unit_id::numeric(38,0);

DO $rollback$
DECLARE
    invalid_count integer;
BEGIN
    SELECT count(*)
      INTO invalid_count
      FROM rollback_7307_targets targets
      LEFT JOIN information_schema.columns columns
        ON columns.table_schema = targets.table_schema
       AND columns.table_name = targets.table_name
       AND columns.column_name = targets.column_name
     WHERE columns.data_type IS DISTINCT FROM 'numeric'
        OR columns.numeric_precision IS DISTINCT FROM 38
        OR columns.numeric_scale IS DISTINCT FROM 0;

    IF invalid_count <> 0 THEN
        RAISE EXCEPTION
            'Ticket #7307 rollback verification failed for % target columns',
            invalid_count;
    END IF;
END
$rollback$;

COMMIT;
