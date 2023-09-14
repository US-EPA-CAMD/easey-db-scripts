ALTER TABLE IF EXISTS camdmd.nonstandard_code
    ADD CONSTRAINT pk_nonstandard_code PRIMARY KEY (nonstandard_cd),
    ADD CONSTRAINT uq_nonstandard_code_description UNIQUE (nonstandard_description);
