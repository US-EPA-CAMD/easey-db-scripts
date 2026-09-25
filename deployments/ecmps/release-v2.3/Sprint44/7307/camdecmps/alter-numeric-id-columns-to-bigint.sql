-- Ticket #7307: convert numeric(38,0) id columns to bigint (camdecmps)

ALTER TABLE IF EXISTS camdecmps.daily_backstop ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.dm_emissions ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.emission_evaluation ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.monitor_location ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.monitor_plan ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.qa_cert_event ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.qa_supp_data ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.stack_pipe ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.test_extension_exemption ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.unit_capacity ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.unit_control ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.unit_fuel ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration ALTER COLUMN unit_id TYPE bigint;
