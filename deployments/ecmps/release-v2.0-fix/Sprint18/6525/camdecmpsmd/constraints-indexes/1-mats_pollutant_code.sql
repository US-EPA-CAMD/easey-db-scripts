ALTER TABLE IF EXISTS camdecmpsmd.mats_pollutant_code
    ADD CONSTRAINT pk_mats_pollutant_code PRIMARY KEY (mats_pollutant_cd),
    ADD CONSTRAINT uq_mats_pollutant_code_1 UNIQUE (mats_pollutant_description),
    ADD CONSTRAINT uq_mats_pollutant_code_2 UNIQUE (metadata_pollutant_cd);

