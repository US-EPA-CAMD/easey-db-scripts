ALTER TABLE IF EXISTS camdecmpsmd.fuel_type_code
    ADD CONSTRAINT pk_fuel_type_code PRIMARY KEY (fuel_type_cd),
    ADD CONSTRAINT uq_fuel_type_code_description UNIQUE (fuel_type_description),
    ADD CONSTRAINT fk_fuel_type_code_fuel_group_code FOREIGN KEY (fuel_group_cd)
        REFERENCES camdecmpsmd.fuel_group_code (fuel_group_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_fuel_type_code_fuel_group_cd
    ON camdecmpsmd.fuel_type_code USING btree
    (fuel_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);
