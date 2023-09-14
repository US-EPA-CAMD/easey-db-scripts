ALTER TABLE IF EXISTS camdmd.class_code
    ADD CONSTRAINT pk_class_code PRIMARY KEY (class_cd),
    ADD CONSTRAINT uq_class_code_description UNIQUE (class_description);
