ALTER TABLE IF EXISTS camddmw.control_year_dim
    ADD CONSTRAINT control_year_dim_pk PRIMARY KEY (unit_id, op_year, control_code, "parameter");

ALTER TABLE IF EXISTS camddmw.control_year_dim
    ADD CONSTRAINT control_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
