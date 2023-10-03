ALTER TABLE IF EXISTS camddmw.account_fact
    ADD CONSTRAINT pk_account_fact PRIMARY KEY (account_number, prg_code),
    ADD CONSTRAINT uq_account_fact UNIQUE (state, account_number, prg_code);

CREATE INDEX IF NOT EXISTS idx_account_fact_source_cat
    ON camddmw.account_fact USING btree
    (source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_op_status
    ON camddmw.account_fact USING btree
    (op_status COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_account_number
    ON camddmw.account_fact USING btree
    (account_number COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_account_name
    ON camddmw.account_fact USING btree
    (account_name COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_account_type
    ON camddmw.account_fact USING btree
    (account_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_account_type_code
    ON camddmw.account_fact USING btree
    (account_type_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_state
    ON camddmw.account_fact USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_state_name
    ON camddmw.account_fact USING btree
    (state_name COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_fac_id
    ON camddmw.account_fact USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_orispl_code
    ON camddmw.account_fact USING btree
    (orispl_code ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_prg_code
    ON camddmw.account_fact USING btree
    (prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS account_fact_idx_unit_id
    ON camddmw.account_fact USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS account_fact_idx_unit_name
    ON camddmw.account_fact USING btree
    (unitid COLLATE pg_catalog."default" ASC NULLS LAST);

/*
CREATE INDEX IF NOT EXISTS idx_account_fact_?
    ON camddmw.account_fact USING btree
    (epa_region ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_account_fact_?
    ON camddmw.account_fact USING btree
    (nerc_region COLLATE pg_catalog."default" ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);
*/