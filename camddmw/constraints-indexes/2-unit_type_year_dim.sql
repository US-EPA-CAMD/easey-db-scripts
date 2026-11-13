ALTER TABLE IF EXISTS camddmw.unit_type_year_dim
    ADD CONSTRAINT unit_type_year_dim_pk PRIMARY KEY (unit_id, unit_type, op_year);

ALTER TABLE IF EXISTS camddmw.unit_type_year_dim
    ADD CONSTRAINT unit_type_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
