ALTER TABLE IF EXISTS camdecmpsmd.mats_status_code
    ADD CONSTRAINT pk_mats_status_code PRIMARY KEY (mats_status_cd),
    ADD CONSTRAINT uq_mats_status_code UNIQUE (mats_status_description);

