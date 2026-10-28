ALTER TABLE IF EXISTS camddmw.unit_compliance_dim
    ADD CONSTRAINT unit_compliance_dim_pk PRIMARY KEY (unit_id, op_year);

ALTER TABLE IF EXISTS camddmw.unit_compliance_dim
    ADD CONSTRAINT unit_compliance_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;
