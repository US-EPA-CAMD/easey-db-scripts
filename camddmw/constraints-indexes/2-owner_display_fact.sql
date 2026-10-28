ALTER TABLE IF EXISTS camddmw.owner_display_fact
    ADD CONSTRAINT owner_display_fact_pk PRIMARY KEY (unit_id, op_year);

ALTER TABLE IF EXISTS camddmw.owner_display_fact
    ADD CONSTRAINT owner_display_fact_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	
