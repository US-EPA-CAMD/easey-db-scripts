ALTER TABLE IF EXISTS camdmd.source_category_code
    ADD CONSTRAINT pk_source_category_code PRIMARY KEY (source_category_cd),
    ADD CONSTRAINT uq_source_category_code_description UNIQUE (source_category_description);
