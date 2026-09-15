-- Ticket #7307: convert numeric(38,0) id columns to bigint (camddmw_arch)

ALTER TABLE IF EXISTS camddmw_arch.day_unit_data_a ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw_arch.hour_unit_data_a ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw_arch.hour_unit_mats_data_a ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw_arch.month_unit_data_a ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw_arch.quarter_unit_data_a ALTER COLUMN rpt_period_id TYPE bigint;
