ALTER TABLE IF EXISTS camdecmpsmd.units_of_measure_code
    ADD CONSTRAINT pk_units_of_measure_code PRIMARY KEY (uom_cd),
    ADD CONSTRAINT uq_units_of_measure_code_description UNIQUE (uom_cd_description);
