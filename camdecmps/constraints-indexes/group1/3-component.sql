ALTER TABLE IF EXISTS camdecmps.component
    ADD CONSTRAINT pk_component PRIMARY KEY (component_id),
    ADD CONSTRAINT fk_component_acquisition_method_code FOREIGN KEY (acq_cd)
        REFERENCES camdecmpsmd.acquisition_method_code (acq_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_basis_code FOREIGN KEY (basis_cd)
        REFERENCES camdecmpsmd.basis_code (basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
	  ADD CONSTRAINT fk_component_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		    ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_component_acq_cd
    ON camdecmps.component USING btree
    (acq_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_basis_cd
    ON camdecmps.component USING btree
    (basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_type_cd
    ON camdecmps.component USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_mon_loc_id
    ON camdecmps.component USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_identifier
    ON camdecmps.component USING btree
    (component_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_component_
    ON camdecmps.component USING btree (
		mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST,
		component_identifier COLLATE pg_catalog."default" ASC NULLS LAST,
		component_id COLLATE pg_catalog."default" ASC NULLS LAST
	);
*/
