ALTER TABLE IF EXISTS camdecmpsmd.nsps4t_emission_standard_code
    ADD CONSTRAINT pk_nsps4t_emission_standard_code PRIMARY KEY (emission_standard_cd),
    ADD CONSTRAINT uq_nsps4t_emission_standard_code_description UNIQUE (emission_standard_description),
    ADD CONSTRAINT fk_nsps4t_emission_standard_code_nsps4t_electrical_load_code FOREIGN KEY (emission_standard_load_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_emission_standard_code_units_of_measure_code FOREIGN KEY (emission_standard_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_emission_standard_code_emission_standard_load_cd
    ON camdecmpsmd.nsps4t_emission_standard_code USING btree
    (emission_standard_load_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_emission_standard_code_emission_standard_uom_cd
    ON camdecmpsmd.nsps4t_emission_standard_code USING btree
    (emission_standard_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
