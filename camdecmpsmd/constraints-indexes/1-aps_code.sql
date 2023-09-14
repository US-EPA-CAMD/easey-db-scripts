ALTER TABLE IF EXISTS camdecmpsmd.aps_code
    ADD CONSTRAINT pk_aps_code PRIMARY KEY (aps_cd),
    ADD CONSTRAINT uq_aps_code_description UNIQUE (aps_description);
