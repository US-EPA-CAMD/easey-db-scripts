-- Ticket #7307: convert numeric(38,0) id columns to bigint (camdecmpsmd)

ALTER TABLE IF EXISTS camdecmpsmd.earliest_partition_quarter ALTER COLUMN earliest_partition_quarter_id TYPE bigint, ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsmd.parameter_uom ALTER COLUMN param_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsmd.reporting_period ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camdecmpsmd.rule_check ALTER COLUMN check_catalog_id TYPE bigint, ALTER COLUMN rule_check_id TYPE bigint;
