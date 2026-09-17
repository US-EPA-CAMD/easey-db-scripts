-- Ticket #7307: convert numeric(38,0) id columns to bigint (camd)

ALTER TABLE IF EXISTS camd.generator ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN gen_id TYPE bigint;
ALTER TABLE IF EXISTS camd.plant ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN first_ecmps_rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camd.plant_person ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN fac_ppl_id TYPE bigint, ALTER COLUMN ppl_id TYPE bigint;
ALTER TABLE IF EXISTS camd.program ALTER COLUMN prg_id TYPE bigint;
ALTER TABLE IF EXISTS camd.program_phase ALTER COLUMN prg_id TYPE bigint, ALTER COLUMN program_phase_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit_boiler_type ALTER COLUMN unit_boiler_type_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit_exemption ALTER COLUMN submitter_ppl_id TYPE bigint, ALTER COLUMN unit_exempt_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit_generator ALTER COLUMN gen_id TYPE bigint, ALTER COLUMN unit_gen_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit_op_status ALTER COLUMN unit_id TYPE bigint, ALTER COLUMN unit_op_status_id TYPE bigint;
ALTER TABLE IF EXISTS camd.unit_program ALTER COLUMN prg_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint, ALTER COLUMN up_id TYPE bigint;
