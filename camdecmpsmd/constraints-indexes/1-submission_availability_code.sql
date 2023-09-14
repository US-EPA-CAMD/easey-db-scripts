ALTER TABLE IF EXISTS camdecmpsmd.submission_availability_code
    ADD CONSTRAINT pk_submission_availability_code PRIMARY KEY (submission_availability_cd),
    ADD CONSTRAINT uq_submission_availability_code_description UNIQUE (sub_avail_cd_description);
