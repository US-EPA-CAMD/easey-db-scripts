-- Ticket #7307: convert numeric(38,0) id columns to bigint (camdecmpsaux)

ALTER TABLE IF EXISTS camdecmpsaux.apportionment ALTER COLUMN apport_id TYPE bigint, ALTER COLUMN begin_rpt_period_id TYPE bigint, ALTER COLUMN end_rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data ALTER COLUMN apport_data_id TYPE bigint, ALTER COLUMN apport_range_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range ALTER COLUMN apport_id TYPE bigint, ALTER COLUMN apport_range_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.check_log ALTER COLUMN check_catalog_result_id TYPE bigint, ALTER COLUMN error_suppress_id TYPE bigint, ALTER COLUMN rule_check_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.check_session ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.email_to_process ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.es_spec ALTER COLUMN check_catalog_result_id TYPE bigint, ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission ALTER COLUMN fac_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_monitor_hour ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_monitor_hour ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_report ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.program_parameter ALTER COLUMN begin_rpt_period_id TYPE bigint, ALTER COLUMN end_rpt_period_id TYPE bigint, ALTER COLUMN prg_id TYPE bigint, ALTER COLUMN prg_param_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.submission_queue ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsaux.submission_set ALTER COLUMN fac_id TYPE bigint;
