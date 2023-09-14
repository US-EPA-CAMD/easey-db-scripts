ALTER TABLE IF EXISTS camdmd.applicability_status_code
    ADD CONSTRAINT pk_applicability_status_code PRIMARY KEY (app_status_cd),
    ADD CONSTRAINT uq_applicability_status_code_description UNIQUE (app_status_description);
