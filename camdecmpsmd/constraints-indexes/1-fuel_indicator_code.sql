ALTER TABLE IF EXISTS camdecmpsmd.fuel_indicator_code
    ADD CONSTRAINT pk_fuel_indicator_code PRIMARY KEY (fuel_indicator_cd),
    ADD CONSTRAINT uq_fuel_indicator_code_description UNIQUE (fuel_indicator_description);
