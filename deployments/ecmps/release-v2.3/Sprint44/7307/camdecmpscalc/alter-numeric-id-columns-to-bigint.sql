-- Ticket #7307: convert numeric(38,0) id columns to bigint (camdecmpscalc)

ALTER TABLE IF EXISTS camdecmpscalc.component_op_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.daily_test_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.daily_test_system_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.last_qa_value_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.operating_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.qa_cert_event_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.qa_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.summary_value ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpscalc.system_op_supp_data ALTER COLUMN rpt_period_id TYPE bigint;
