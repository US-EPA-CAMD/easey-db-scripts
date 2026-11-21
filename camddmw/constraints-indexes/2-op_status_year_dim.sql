ALTER TABLE IF EXISTS camddmw.op_status_year_dim
    ADD CONSTRAINT op_status_year_dim_pk PRIMARY KEY (op_year, unit_id);

ALTER TABLE IF EXISTS camddmw.op_status_year_dim
    ADD CONSTRAINT op_status_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
	
CREATE INDEX op_status_year_dim_unit_id_op_status_ix
	ON camddmw.op_status_year_dim USING btree 
	(unit_id, op_status);	
