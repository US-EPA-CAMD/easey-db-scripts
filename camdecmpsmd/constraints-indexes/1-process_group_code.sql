ALTER TABLE IF EXISTS camdecmpsmd.process_group_code
    ADD CONSTRAINT pk_process_group_code PRIMARY KEY (process_group_cd),
    ADD CONSTRAINT uq_process_group_code_description UNIQUE (process_group_description);
