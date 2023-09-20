ALTER TABLE IF EXISTS camdecmpswks.component
    ADD CONSTRAINT pk_component PRIMARY KEY (component_id),
    ADD CONSTRAINT fk_component_acquisition_method_code FOREIGN KEY (acq_cd)
        REFERENCES camdecmpsmd.acquisition_method_code (acq_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_analytical_principle_code FOREIGN KEY (analytical_principle_cd)
        REFERENCES camdecmpsmd.analytical_principle_code (analytical_principle_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_basis_code FOREIGN KEY (basis_cd)
        REFERENCES camdecmpsmd.basis_code (basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_component_acq_cd
    ON camdecmpswks.component USING btree
    (acq_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_analytical_principle_cd
    ON camdecmpswks.component USING btree
    (basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_type_cd
    ON camdecmpswks.component USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_mon_loc_id
    ON camdecmpswks.component USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_identifier
    ON camdecmpswks.component USING btree
    (component_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_component_
    ON camdecmpswks.component USING btree (
		mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST,
		component_identifier COLLATE pg_catalog."default" ASC NULLS LAST,
		component_id COLLATE pg_catalog."default" ASC NULLS LAST
	);
*/
