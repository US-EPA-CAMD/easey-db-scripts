ALTER TABLE IF EXISTS camddmw.fuel_year_dim
    ADD CONSTRAINT fuel_year_dim_pk PRIMARY KEY (unit_id, fuel_code, op_year, "indicator");

ALTER TABLE IF EXISTS camddmw.fuel_year_dim
    ADD CONSTRAINT fuel_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
