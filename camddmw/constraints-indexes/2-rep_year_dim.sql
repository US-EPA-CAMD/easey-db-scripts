ALTER TABLE IF EXISTS camddmw.rep_year_dim
    ADD CONSTRAINT rep_year_dim_pk PRIMARY KEY (op_year, rep_yr_id);
	
ALTER TABLE IF EXISTS camddmw.rep_year_dim
    ADD CONSTRAINT rep_year_dim_uq UNIQUE (unit_id, op_year, ppl_id, prg_code, rep_code, begin_date);	

ALTER TABLE IF EXISTS camddmw.rep_year_dim
    ADD CONSTRAINT rep_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	

CREATE INDEX rep_year_dim_unit_id_ppl_id_ix
	ON camddmw.rep_year_dim USING btree 
	(unit_id, ppl_id);

CREATE INDEX rep_year_dim_ppl_id_ix
	ON camddmw.rep_year_dim USING btree 
	(ppl_id);

CREATE INDEX rep_year_dim_unit_id_op_year_ix
	ON camddmw.rep_year_dim USING btree 
	(unit_id, op_year);
