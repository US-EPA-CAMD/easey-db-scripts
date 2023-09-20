ALTER TABLE IF EXISTS camdmd.generator_source_code
    ADD CONSTRAINT pk_generator_source_code PRIMARY KEY (gen_source_cd),
    ADD CONSTRAINT uq_generator_source_code_description UNIQUE (gen_source_description)
