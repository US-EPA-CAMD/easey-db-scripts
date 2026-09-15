-- Ticket #7307: convert numeric(38,0) id columns to bigint (camddmw)

ALTER TABLE IF EXISTS camddmw.account_fact ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.account_owner_dim ALTER COLUMN account_owner_unique_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.day_unit_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.hour_unit_data ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.hour_unit_mats_data ALTER COLUMN rpt_period_id TYPE bigint, ALTER COLUMN unit_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.month_unit_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.quarter_unit_data ALTER COLUMN rpt_period_id TYPE bigint;
ALTER TABLE IF EXISTS camddmw.transaction_owner_dim ALTER COLUMN transaction_owner_unique_id TYPE bigint;
