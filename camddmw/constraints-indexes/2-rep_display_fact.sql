ALTER TABLE IF EXISTS camddmw.rep_display_fact
    ADD CONSTRAINT rep_display_fact_pk PRIMARY KEY (op_year, rep_fact_id);

ALTER TABLE IF EXISTS camddmw.rep_display_fact
    ADD CONSTRAINT rep_display_fact_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	

ALTER TABLE IF EXISTS camddmw.rep_display_fact
    ADD CONSTRAINT rep_display_fact_uq UNIQUE (unit_id, op_year, prg_code);	
	
CREATE INDEX rep_display_fact_unit_account_alt_prm_prg_ix 
	ON camddmw.rep_display_fact USING btree 
	(unit_id, account_number, alt_display_block, alt_display_name, prm_display_block, prm_display_name, prg_code);
