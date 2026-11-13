ALTER TABLE IF EXISTS camddmw.account_fact
    ADD CONSTRAINT account_fact_pk PRIMARY KEY (account_number, prg_code);

CREATE INDEX IF NOT EXISTS account_fact_fac_id_ix
    ON camddmw.account_fact USING btree
    (fac_id);

CREATE INDEX IF NOT EXISTS account_fact_prg_code_ix
    ON camddmw.account_fact USING btree
    (prg_code);

CREATE INDEX IF NOT EXISTS account_fact_unit_id_ix
    ON camddmw.account_fact USING btree
    (unit_id);

CREATE INDEX IF NOT EXISTS account_fact_state_ix
    ON camddmw.account_fact USING btree
    ("state");

CREATE INDEX IF NOT EXISTS account_fact_epa_region_op_status_info_source_cat_ix
    ON camddmw.account_fact USING btree
    (epa_region, op_status_info, source_cat);

CREATE INDEX IF NOT EXISTS account_fact_nerc_region_op_status_info_source_cat_ix
    ON camddmw.account_fact USING btree
    (nerc_region, op_status_info, source_cat);
