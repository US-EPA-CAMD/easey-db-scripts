ALTER TABLE IF EXISTS camdecmpsmd.hour_measure_code
    ADD CONSTRAINT pk_hour_measure_code PRIMARY KEY (hour_measure_cd),
    ADD CONSTRAINT uq_hour_measure_code_description UNIQUE (hour_measure_description);
