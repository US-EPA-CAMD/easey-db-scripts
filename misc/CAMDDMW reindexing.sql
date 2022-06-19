ALTER TABLE camddmw.account_compliance_dim DROP CONSTRAINT IF EXISTS account_compliance_dim_fk;
ALTER TABLE camddmw.account_compliance_dim DROP CONSTRAINT IF EXISTS fk_account_compliance_dim;
ALTER TABLE camddmw.account_compliance_dim DROP CONSTRAINT IF EXISTS pk_account_compliance_dim;
ALTER TABLE camddmw.account_fact DROP CONSTRAINT IF EXISTS pk_account_fact;
DROP INDEX IF EXISTS camddmw.account_fact_idx001;
DROP INDEX IF EXISTS camddmw.account_fact_idx002;
DROP INDEX IF EXISTS camddmw.account_fact_idx003;
DROP INDEX IF EXISTS camddmw.account_fact_idx004;
DROP INDEX IF EXISTS camddmw.account_fact_idx005;
DROP INDEX IF EXISTS camddmw.account_fact_idx_unit;
DROP INDEX IF EXISTS camddmw.unq_account_fact;
DROP INDEX IF EXISTS camddmw.idx_account_fact_1;
DROP INDEX IF EXISTS camddmw.idx_account_fact_2;
DROP INDEX IF EXISTS camddmw.idx_account_fact_fac_id;
DROP INDEX IF EXISTS camddmw.idx_account_fact_prg_code;
DROP INDEX IF EXISTS camddmw.idx_account_fact_unit_id;
ALTER TABLE camddmw.account_owner_dim DROP CONSTRAINT IF EXISTS account_owner_dim_pk;
ALTER TABLE camddmw.account_owner_dim DROP CONSTRAINT IF EXISTS pk_account_owner_dim;
ALTER TABLE camddmw.allowance_holding_dim DROP CONSTRAINT IF EXISTS allowance_holding_dim_pk;
ALTER TABLE camddmw.allowance_holding_dim DROP CONSTRAINT IF EXISTS pk_allowance_holding_dim;
DROP INDEX IF EXISTS camddmw.all_hold_dim_idx1;
DROP INDEX IF EXISTS camddmw.idx_allowance_holding_dim_1;
DROP INDEX IF EXISTS camddmw.allowance_holding_dim_idx002;
DROP INDEX IF EXISTS camddmw.idx_allowance_holding_dim_2;
ALTER TABLE camddmw.annual_unit_data DROP CONSTRAINT IF EXISTS pk_annual_unit_data;
ALTER TABLE camddmw.control_year_dim DROP CONSTRAINT IF EXISTS pk_control_year_dim;
ALTER TABLE camddmw.control_year_dim DROP CONSTRAINT IF EXISTS unq_control_year_dim;
ALTER TABLE camddmw.day_unit_data DROP CONSTRAINT IF EXISTS pk_day_unit_data;
DROP INDEX IF EXISTS camddmw.idx_day_unit_data_op_month;
DROP INDEX IF EXISTS camddmw.idx_day_unit_data_op_year;
DROP INDEX IF EXISTS camddmw.idx_day_unit_data_rpt_period_id;
ALTER TABLE camddmw.fuel_year_dim DROP CONSTRAINT IF EXISTS pk_fuel_year_dim;
ALTER TABLE camddmw.hour_unit_data DROP CONSTRAINT IF EXISTS pk_hour_unit_data;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_op_time;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_op_year;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_rpt_period_id;
ALTER TABLE camddmw.hour_unit_data_log DROP CONSTRAINT IF EXISTS pk_hour_unit_data_log;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_op_date;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_op_hour;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_op_time;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_op_year;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_sql_function;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_data_log_unit_id;
ALTER TABLE camddmw.hour_unit_mats_data DROP CONSTRAINT IF EXISTS pk_hour_unit_mats_data;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_op_time;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_op_year;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_rpt_period_id;
ALTER TABLE camddmw.hour_unit_mats_data_log DROP CONSTRAINT IF EXISTS pk_hour_unit_mats_data_log;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_date;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_hour;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_time;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_year;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_sql_function;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_unit_id;
ALTER TABLE camddmw.month_unit_data DROP CONSTRAINT IF EXISTS pk_month_unit_data;
DROP INDEX IF EXISTS camddmw.idx_month_unit_data_op_quarter;
DROP INDEX IF EXISTS camddmw.idx_month_unit_data_rpt_period_id;
ALTER TABLE camddmw.owner_display_fact DROP CONSTRAINT IF EXISTS pk_owner_display_fact;
ALTER TABLE camddmw.owner_year_dim DROP CONSTRAINT IF EXISTS pk_owner_year_dim;
ALTER TABLE camddmw.owner_year_dim DROP CONSTRAINT IF EXISTS unq_owner_year_dim;
ALTER TABLE camddmw.ozone_unit_data DROP CONSTRAINT IF EXISTS pk_ozone_unit_data;
ALTER TABLE camddmw.program_year_dim DROP CONSTRAINT IF EXISTS pk_prog_year_dim;
ALTER TABLE camddmw.program_year_dim DROP CONSTRAINT IF EXISTS pk_program_year_dim;
ALTER TABLE camddmw.quarter_unit_data DROP CONSTRAINT IF EXISTS quarter_unit_data_pk;
ALTER TABLE camddmw.quarter_unit_data DROP CONSTRAINT IF EXISTS pk_quarter_unit_data_pk;
DROP INDEX IF EXISTS camddmw.idx_quarter_unit_data_rpt_period_id;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS transaction_block_dim_fk;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS fk_transaction_block_dim_transaction_fact;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS transaction_block_dim_transaction_id_prg_code_fkey;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS fk_transaction_block_dim_transaction_fact_p1;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS transaction_block_dim_transaction_id_prg_code_fkey1;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS fk_transaction_block_dim_transaction_fact_p2;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS transaction_block_dim_transaction_id_prg_code_fkey2;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS fk_transaction_block_dim_transaction_fact_unknown;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS trnsctn_blk_dim_pk;
ALTER TABLE camddmw.transaction_block_dim DROP CONSTRAINT IF EXISTS pk_transaction_block_diom;
DROP INDEX IF EXISTS camddmw.transaction_block_dim_idx001;
DROP INDEX IF EXISTS camddmw.idx_transaction_block_dim_1;
ALTER TABLE camddmw.transaction_fact DROP CONSTRAINT IF EXISTS trnsctn_fact_pk;
ALTER TABLE camddmw.transaction_fact DROP CONSTRAINT IF EXISTS pk_transaction_fact;
DROP INDEX IF EXISTS camddmw.transaction_fact_idx002;
DROP INDEX IF EXISTS camddmw.transaction_fact_idx003;
DROP INDEX IF EXISTS camddmw.transaction_fact_idx004;
DROP INDEX IF EXISTS camddmw.transaction_fact_idx005;
DROP INDEX IF EXISTS camddmw.idx_transaction_fact_1;
DROP INDEX IF EXISTS camddmw.idx_transaction_fact_2;
DROP INDEX IF EXISTS camddmw.idx_transaction_fact_3;
DROP INDEX IF EXISTS camddmw.idx_transaction_fact_4;
ALTER TABLE camddmw.transaction_owner_dim DROP CONSTRAINT IF EXISTS transaction_owner_dim_pk;
ALTER TABLE camddmw.transaction_owner_dim DROP CONSTRAINT IF EXISTS pk_transaction_owner_dim;
DROP INDEX IF EXISTS camddmw.transaction_owner_dim_fk;
DROP INDEX IF EXISTS camddmw.idx_transaction_owner_dim_1;
DROP INDEX IF EXISTS camddmw.transaction_owner_dim_idx001;
DROP INDEX IF EXISTS camddmw.idx_transaction_owner_dim_2;
DROP INDEX IF EXISTS camddmw.transaction_owner_dim_idx002;
DROP INDEX IF EXISTS camddmw.idx_transaction_owner_dim_3;
ALTER TABLE camddmw.unit_compliance_dim DROP CONSTRAINT IF EXISTS pk_unit_compliance_dim;
ALTER TABLE camddmw.unit_fact DROP CONSTRAINT IF EXISTS pk_unit_fact;
DROP INDEX IF EXISTS camddmw.idx_unit_fact_fac_id;
DROP INDEX IF EXISTS camddmw.idx_unit_fact_orispl_code;
DROP INDEX IF EXISTS camddmw.idx_unit_fact_state;
ALTER TABLE camddmw.unit_type_year_dim DROP CONSTRAINT IF EXISTS pk_unit_type_year_dim;



ALTER TABLE camddmw.account_compliance_dim
    ADD CONSTRAINT pk_account_compliance_dim PRIMARY KEY (account_number, prg_code, op_year);

ALTER TABLE camddmw.account_fact
    ADD CONSTRAINT pk_account_fact PRIMARY KEY (account_number, prg_code);

ALTER TABLE camddmw.account_owner_dim
    ADD CONSTRAINT pk_account_owner_dim PRIMARY KEY (account_owner_unique_id);

ALTER TABLE camddmw.allowance_holding_dim
    ADD CONSTRAINT pk_allowance_holding_dim PRIMARY KEY (vintage_year, prg_code, start_block);

ALTER TABLE camddmw.annual_unit_data
    ADD CONSTRAINT pk_annual_unit_data PRIMARY KEY (unit_id, op_year);

--ALTER TABLE camddmw.control_year_dim
--    ADD CONSTRAINT pk_control_year_dim PRIMARY KEY (control_year_id);

ALTER TABLE camddmw.day_unit_data
    ADD CONSTRAINT pk_day_unit_data PRIMARY KEY (unit_id, op_date);

ALTER TABLE camddmw.fuel_year_dim
    ADD CONSTRAINT pk_fuel_year_dim PRIMARY KEY (unit_id, fuel_code, op_year, indicator);

ALTER TABLE camddmw.hour_unit_data
    ADD CONSTRAINT pk_hour_unit_data PRIMARY KEY (unit_id, op_date, op_hour);

ALTER TABLE camddmw.hour_unit_data_log
    ADD CONSTRAINT pk_hour_unit_data_log PRIMARY KEY (skey);

ALTER TABLE camddmw.hour_unit_mats_data
    ADD CONSTRAINT pk_hour_unit_mats_data PRIMARY KEY (unit_id, op_date, op_hour);

ALTER TABLE camddmw.hour_unit_mats_data_log
    ADD CONSTRAINT pk_hour_unit_mats_data_log PRIMARY KEY (skey);

ALTER TABLE camddmw.month_unit_data
    ADD CONSTRAINT pk_month_unit_data PRIMARY KEY (unit_id, op_year, op_month);

ALTER TABLE camddmw.owner_display_fact
    ADD CONSTRAINT pk_owner_display_fact PRIMARY KEY (unit_id, op_year);

ALTER TABLE camddmw.owner_year_dim
    ADD CONSTRAINT pk_owner_year_dim PRIMARY KEY (own_yr_id);

ALTER TABLE camddmw.ozone_unit_data
    ADD CONSTRAINT pk_ozone_unit_data PRIMARY KEY (unit_id, op_year);

ALTER TABLE camddmw.program_year_dim
    ADD CONSTRAINT pk_program_year_dim PRIMARY KEY (unit_id, prg_code, op_year);

ALTER TABLE camddmw.quarter_unit_data
    ADD CONSTRAINT pk_quarter_unit_data PRIMARY KEY (unit_id, op_year, op_quarter);

ALTER TABLE camddmw.transaction_block_dim
    ADD CONSTRAINT pk_transaction_block_diom PRIMARY KEY (transaction_block_id, prg_code);

ALTER TABLE camddmw.transaction_fact
    ADD CONSTRAINT pk_transaction_fact PRIMARY KEY (transaction_id, prg_code);

ALTER TABLE camddmw.transaction_owner_dim
    ADD CONSTRAINT pk_transaction_owner_dim PRIMARY KEY (transaction_owner_unique_id);

ALTER TABLE camddmw.unit_compliance_dim
    ADD CONSTRAINT pk_unit_compliance_dim PRIMARY KEY (unit_id, op_year);

ALTER TABLE camddmw.unit_fact
    ADD CONSTRAINT pk_unit_fact PRIMARY KEY (unit_id, op_year);

ALTER TABLE camddmw.unit_type_year_dim
    ADD CONSTRAINT pk_unit_type_year_dim PRIMARY KEY (unit_id, unit_type, op_year);

ALTER TABLE camddmw.account_compliance_dim
    ADD CONSTRAINT fk_account_compliance_dim FOREIGN KEY (account_number, prg_code)
    REFERENCES camddmw.account_fact (account_number, prg_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

CREATE UNIQUE INDEX unq_account_fact
    ON camddmw.account_fact USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST, account_number COLLATE pg_catalog."default" ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_account_fact_1
    ON camddmw.account_fact USING btree
    (epa_region ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_account_fact_2
    ON camddmw.account_fact USING btree
    (nerc_region COLLATE pg_catalog."default" ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_account_fact_fac_id
    ON camddmw.account_fact USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX idx_account_fact_prg_code
    ON camddmw.account_fact USING btree
    (prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_account_fact_unit_id
    ON camddmw.account_fact USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX idx_allowance_holding_dim_1
    ON camddmw.allowance_holding_dim USING btree
    (prg_code COLLATE pg_catalog."default" ASC NULLS LAST, start_block ASC NULLS LAST);

CREATE INDEX idx_allowance_holding_dim_2
    ON camddmw.allowance_holding_dim USING btree
    (account_number COLLATE pg_catalog."default" ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST, allowance_type COLLATE pg_catalog."default" ASC NULLS LAST);

ALTER TABLE camddmw.control_year_dim
    ADD CONSTRAINT unq_control_year_dim UNIQUE (unit_id, op_year, control_code, parameter);

CREATE INDEX idx_day_unit_data_op_month
    ON camddmw.day_unit_data USING btree
    (op_month ASC NULLS LAST);

CREATE INDEX idx_day_unit_data_op_year
    ON camddmw.day_unit_data USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX idx_day_unit_data_rpt_period_id
    ON camddmw.day_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_op_time
    ON camddmw.hour_unit_data USING btree
    (op_time ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_op_year
    ON camddmw.hour_unit_data USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_rpt_period_id
    ON camddmw.hour_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_op_date
    ON camddmw.hour_unit_data_log USING btree
    (op_date ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_op_hour
    ON camddmw.hour_unit_data_log USING btree
    (op_hour ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_op_time
    ON camddmw.hour_unit_data_log USING btree
    (op_time ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_op_year
    ON camddmw.hour_unit_data_log USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_sql_function
    ON camddmw.hour_unit_data_log USING btree
    (sql_function COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_hour_unit_data_log_unit_id
    ON camddmw.hour_unit_data_log USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_op_time
    ON camddmw.hour_unit_mats_data USING btree
    (op_time ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_op_year
    ON camddmw.hour_unit_mats_data USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_rpt_period_id
    ON camddmw.hour_unit_mats_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_op_date
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_date ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_op_hour
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_hour ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_op_time
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_time ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_op_year
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_sql_function
    ON camddmw.hour_unit_mats_data_log USING btree
    (sql_function COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_hour_unit_mats_data_log_unit_id
    ON camddmw.hour_unit_mats_data_log USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX idx_month_unit_data_op_quarter
    ON camddmw.month_unit_data USING btree
    (op_quarter ASC NULLS LAST);

CREATE INDEX idx_month_unit_data_rpt_period_id
    ON camddmw.month_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

ALTER TABLE camddmw.owner_year_dim
    ADD CONSTRAINT unq_owner_year_dim UNIQUE (unit_id, op_year, own_id, own_type);

CREATE INDEX idx_quarter_unit_data_rpt_period_id
    ON camddmw.quarter_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

ALTER TABLE camddmw.transaction_block_dim
    ADD CONSTRAINT fk_transaction_block_dim_transaction_fact FOREIGN KEY (prg_code, transaction_id)
    REFERENCES camddmw.transaction_fact (prg_code, transaction_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

/*
ALTER TABLE camddmw.transaction_block_dim
    ADD CONSTRAINT fk_transaction_block_dim_transaction_fact_p1 FOREIGN KEY (prg_code, transaction_id)
    REFERENCES camddmw.transaction_fact_trans_fact_p1 (prg_code, transaction_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE camddmw.transaction_block_dim
    ADD CONSTRAINT fk_transaction_block_dim_transaction_fact_p2 FOREIGN KEY (prg_code, transaction_id)
    REFERENCES camddmw.transaction_fact_trans_fact_p2 (prg_code, transaction_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE camddmw.transaction_block_dim
    ADD CONSTRAINT fk_transaction_block_dim_transaction_fact_unknown FOREIGN KEY (prg_code, transaction_id)
    REFERENCES camddmw.transaction_fact_trans_fact_unknown (prg_code, transaction_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
*/

CREATE INDEX idx_transaction_block_dim_1
    ON camddmw.transaction_block_dim USING btree
    (transaction_id ASC NULLS LAST, vintage_year ASC NULLS LAST, start_block ASC NULLS LAST, end_block ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_transaction_fact_1
    ON camddmw.transaction_fact USING btree
    (transaction_date ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, sell_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, transaction_id ASC NULLS LAST);

CREATE INDEX idx_transaction_fact_2
    ON camddmw.transaction_fact USING btree
    (transaction_id ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, sell_acct_number COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_transaction_fact_3
    ON camddmw.transaction_fact USING btree
    (buy_fac_id ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, buy_source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_transaction_fact_4
    ON camddmw.transaction_fact USING btree
    (buy_state COLLATE pg_catalog."default" ASC NULLS LAST, buy_source_cat COLLATE pg_catalog."default" ASC NULLS LAST, buy_fac_id ASC NULLS LAST);

CREATE INDEX idx_transaction_owner_dim_1
    ON camddmw.transaction_owner_dim USING btree
    (transaction_id ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_transaction_owner_dim_2
    ON camddmw.transaction_owner_dim USING btree
    (own_id ASC NULLS LAST, ppl_id ASC NULLS LAST);

CREATE INDEX idx_transaction_owner_dim_3
    ON camddmw.transaction_owner_dim USING btree
    (ppl_id ASC NULLS LAST, own_id ASC NULLS LAST);

CREATE INDEX idx_unit_fact_fac_id
    ON camddmw.unit_fact USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX idx_unit_fact_orispl_code
    ON camddmw.unit_fact USING btree
    (orispl_code ASC NULLS LAST);

CREATE INDEX idx_unit_fact_state
    ON camddmw.unit_fact USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST);



VACUUM FULL ANALYZE camddmw.account_compliance_dim
, camddmw.account_fact
, camddmw.account_owner_dim
, camddmw.allowance_holding_dim
, camddmw.annual_unit_data
, camddmw.control_year_dim
, camddmw.day_unit_data
, camddmw.fuel_year_dim
, camddmw.hour_unit_data
, camddmw.hour_unit_data_log
, camddmw.hour_unit_mats_data
, camddmw.hour_unit_mats_data_log
, camddmw.month_unit_data
, camddmw.owner_display_fact
, camddmw.owner_year_dim
, camddmw.ozone_unit_data
, camddmw.program_year_dim
, camddmw.quarter_unit_data
, camddmw.transaction_block_dim
, camddmw.transaction_fact
, camddmw.transaction_owner_dim
, camddmw.unit_compliance_dim
, camddmw.unit_fact
, camddmw.unit_type_year_dim
;

SELECT pg_size_pretty( pg_database_size('cgawsbrokerprod4dsl7fy3') + pg_database_size('postgres') + pg_database_size('rdsadmin'));
