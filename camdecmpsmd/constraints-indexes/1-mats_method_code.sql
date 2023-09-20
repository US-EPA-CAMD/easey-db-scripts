ALTER TABLE IF EXISTS camdecmpsmd.mats_method_code
    ADD CONSTRAINT pk_mats_method_code PRIMARY KEY (mats_method_cd),
    ADD CONSTRAINT uq_mats_method_code_description UNIQUE (mats_method_description);
