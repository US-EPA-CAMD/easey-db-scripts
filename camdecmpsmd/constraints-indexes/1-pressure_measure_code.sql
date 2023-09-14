ALTER TABLE IF EXISTS camdecmpsmd.pressure_measure_code
    ADD CONSTRAINT pk_pressure_measure_code PRIMARY KEY (pressure_meas_cd),
    ADD CONSTRAINT uq_pressure_measure_code_description UNIQUE (pressure_meas_cd_description);
