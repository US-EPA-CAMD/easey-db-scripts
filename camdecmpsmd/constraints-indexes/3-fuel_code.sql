ALTER TABLE IF EXISTS camdecmpsmd.fuel_code
    ADD CONSTRAINT pk_fuel_code PRIMARY KEY (fuel_cd),
    ADD CONSTRAINT fk_fuel_code_fuel_group_code FOREIGN KEY (fuel_group_cd)
        REFERENCES camdecmpsmd.fuel_group_code (fuel_group_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_code_fuel_type_code FOREIGN KEY (unit_fuel_cd)
        REFERENCES camdecmpsmd.fuel_type_code (fuel_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_fuel_code_fuel_group_cd
    ON camdecmpsmd.fuel_code USING btree
    (fuel_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_code_fuel_type_code
    ON camdecmpsmd.fuel_code USING btree
    (fuel_type_code COLLATE pg_catalog."default" ASC NULLS LAST);
