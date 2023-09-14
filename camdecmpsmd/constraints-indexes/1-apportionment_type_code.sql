ALTER TABLE IF EXISTS camdecmpsmd.apportionment_type_code
    ADD CONSTRAINT pk_apportionment_type_code PRIMARY KEY (apportionment_type_cd),
    ADD CONSTRAINT uq_apportionment_type_code_description UNIQUE (apportionment_type_description);
