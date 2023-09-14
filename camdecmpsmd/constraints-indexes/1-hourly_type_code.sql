ALTER TABLE IF EXISTS camdecmpsmd.hourly_type_code
    ADD CONSTRAINT pk_hourly_type_code PRIMARY KEY (hourly_type_cd),
    ADD CONSTRAINT uq_hourly_type_code_description UNIQUE (hourly_type_description);
