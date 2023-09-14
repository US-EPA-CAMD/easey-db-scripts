ALTER TABLE IF EXISTS camdecmpsmd.em_status_code
    ADD CONSTRAINT pk_em_status_code PRIMARY KEY (em_status_cd),
    ADD CONSTRAINT uq_em_status_code_description UNIQUE (em_status_cd_description);
