ALTER TABLE IF EXISTS camdecmpsmd.run_status_code
    ADD CONSTRAINT pk_run_status_code PRIMARY KEY (run_status_cd),
    ADD CONSTRAINT uq_run_status_code_description UNIQUE (run_status_description);
