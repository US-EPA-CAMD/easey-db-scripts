-- Ticket #7307: convert numeric(38,0) id columns to bigint (camdecmpswks)

ALTER TABLE IF EXISTS camdecmpswks.check_log ALTER COLUMN check_catalog_result_id TYPE bigint, ALTER COLUMN error_suppress_id TYPE bigint, ALTER COLUMN rule_check_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.daily_backstop ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.monitor_location ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.qa_supp_data ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.stack_pipe ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption ALTER COLUMN submission_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.unit ALTER COLUMN fac_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.unit_capacity ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.unit_control ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.unit_fuel ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration ALTER COLUMN unit_id TYPE bigint;
