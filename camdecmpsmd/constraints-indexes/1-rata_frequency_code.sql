ALTER TABLE IF EXISTS camdecmpsmd.rata_frequency_code
    ADD CONSTRAINT pk_rata_frequency_code PRIMARY KEY (rata_frequency_cd),
    ADD CONSTRAINT uq_rata_frequency_code_description UNIQUE (rata_frequency_cd_description);
