ALTER TABLE IF EXISTS camddmw.unit_fact
    ADD CONSTRAINT unit_fact_pk PRIMARY KEY (unit_id, op_year);

CREATE INDEX unit_fact_fac_id_ix
	ON camddmw.unit_fact USING btree (fac_id);
	
CREATE INDEX unit_fact_orispl_code_ix
	ON camddmw.unit_fact USING btree (orispl_code);
	
CREATE INDEX unit_fact_state_ix
	ON camddmw.unit_fact USING btree ("state");
