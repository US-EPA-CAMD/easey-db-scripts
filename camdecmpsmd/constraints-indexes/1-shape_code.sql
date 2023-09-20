ALTER TABLE IF EXISTS camdecmpsmd.shape_code
    ADD CONSTRAINT pk_shape_code PRIMARY KEY (shape_cd),
    ADD CONSTRAINT uq_shape_code_description UNIQUE (shape_cd_description);
