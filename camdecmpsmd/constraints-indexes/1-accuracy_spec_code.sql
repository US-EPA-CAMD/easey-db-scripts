ALTER TABLE IF EXISTS camdecmpsmd.accuracy_spec_code
    ADD CONSTRAINT pk_accuracy_spec_code PRIMARY KEY (accuracy_spec_cd),
    ADD CONSTRAINT uq_accuracy_spec_code_description UNIQUE (accuracy_spec_cd_description);
