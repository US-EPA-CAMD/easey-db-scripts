ALTER TABLE IF EXISTS camdecmpsmd.check_status_code
    ADD CONSTRAINT pk_check_status_code PRIMARY KEY (check_status_cd),
    ADD CONSTRAINT uq_check_status_code_description UNIQUE (check_status_cd_description);
