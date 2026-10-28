ALTER TABLE IF EXISTS camddmw.owner_year_dim
    ADD CONSTRAINT owner_year_dim_pk PRIMARY KEY (own_yr_id);
	
ALTER TABLE IF EXISTS camddmw.owner_year_dim
    ADD CONSTRAINT owner_year_dim_uq UNIQUE (unit_id, op_year, own_id, own_type);	

ALTER TABLE IF EXISTS camddmw.owner_year_dim
    ADD CONSTRAINT owner_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
