-- convert the approved 55 numeric(38,0) ID columns to integer.
-- Run after 1-drop-dependent-objects.sql.

BEGIN;

ALTER TABLE camd.generator
    ALTER COLUMN gen_id TYPE integer USING gen_id::integer,
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camd.plant
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camd.plant_person
    ALTER COLUMN fac_ppl_id TYPE integer USING fac_ppl_id::integer,
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer,
    ALTER COLUMN ppl_id TYPE integer USING ppl_id::integer;
ALTER TABLE camd.program
    ALTER COLUMN prg_id TYPE integer USING prg_id::integer;
ALTER TABLE camd.program_phase
    ALTER COLUMN program_phase_id TYPE integer USING program_phase_id::integer,
    ALTER COLUMN prg_id TYPE integer USING prg_id::integer;
ALTER TABLE camd.unit
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camd.unit_boiler_type
    ALTER COLUMN unit_boiler_type_id TYPE integer USING unit_boiler_type_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camd.unit_exemption
    ALTER COLUMN unit_exempt_id TYPE integer USING unit_exempt_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer,
    ALTER COLUMN submitter_ppl_id TYPE integer USING submitter_ppl_id::integer;
ALTER TABLE camd.unit_generator
    ALTER COLUMN unit_gen_id TYPE integer USING unit_gen_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer,
    ALTER COLUMN gen_id TYPE integer USING gen_id::integer;
ALTER TABLE camd.unit_op_status
    ALTER COLUMN unit_op_status_id TYPE integer USING unit_op_status_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camd.unit_program
    ALTER COLUMN up_id TYPE integer USING up_id::integer,
    ALTER COLUMN prg_id TYPE integer USING prg_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdaux.inventory_status_log
    ALTER COLUMN inventory_status_log_id TYPE integer USING inventory_status_log_id::integer,
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;

ALTER TABLE camdecmps.daily_backstop
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmps.dm_emissions
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmps.monitor_location
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmps.monitor_plan
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmps.stack_pipe
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmps.unit_capacity
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmps.unit_control
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmps.unit_fuel
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmps.unit_stack_configuration
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;

ALTER TABLE camdecmpsaux.email_to_process
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpsaux.es_spec
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpsaux.evaluation_set
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpsaux.mats_data_submission
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpsaux.pdem_mats_unit_hour
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpsaux.pdem_p75_unit_hour
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpsaux.program_parameter
    ALTER COLUMN prg_id TYPE integer USING prg_id::integer;
ALTER TABLE camdecmpsaux.submission_set
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;

ALTER TABLE camdecmpswks.daily_backstop
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.mats_bulk_file
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpswks.monitor_location
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.monitor_plan
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpswks.stack_pipe
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer;
ALTER TABLE camdecmpswks.unit
    ALTER COLUMN fac_id TYPE integer USING fac_id::integer,
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.unit_capacity
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.unit_control
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.unit_fuel
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;
ALTER TABLE camdecmpswks.unit_stack_configuration
    ALTER COLUMN unit_id TYPE integer USING unit_id::integer;

COMMIT;
