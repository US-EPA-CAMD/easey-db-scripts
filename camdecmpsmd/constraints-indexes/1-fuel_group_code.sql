ALTER TABLE IF EXISTS camdecmpsmd.fuel_group_code
    ADD CONSTRAINT pk_fuel_group_code PRIMARY KEY (fuel_group_cd),
    ADD CONSTRAINT uq_fuel_group_code_description UNIQUE (fuel_group_description);
