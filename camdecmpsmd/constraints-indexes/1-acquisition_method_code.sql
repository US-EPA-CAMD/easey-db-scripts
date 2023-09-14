ALTER TABLE IF EXISTS camdecmpsmd.acquisition_method_code
    ADD CONSTRAINT pk_acquisition_method_code PRIMARY KEY (acq_cd),
    ADD CONSTRAINT uq_acquisition_method_code_description UNIQUE (acq_cd_description);
