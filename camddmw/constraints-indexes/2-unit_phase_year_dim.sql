ALTER TABLE IF EXISTS camddmw.unit_phase_year_dim
    ADD CONSTRAINT unit_phase_year_dim_pk PRIMARY KEY (unit_id, op_year, "parameter");

ALTER TABLE IF EXISTS camddmw.unit_phase_year_dim
    ADD CONSTRAINT unit_phase_year_dim_fk FOREIGN KEY (unit_id, op_year) 
	REFERENCES camddmw.unit_fact(unit_id, op_year) ON DELETE CASCADE;	

CREATE INDEX unit_phase_year_dim_unit_id_op_year_phase_parameter_ix
	ON camddmw.unit_phase_year_dim USING btree (unit_id, op_year, phase, "parameter");

CREATE INDEX unit_phase_year_dim_phase_unit_id_op_year_ix
	ON camddmw.unit_phase_year_dim USING btree (phase, unit_id, op_year);	
