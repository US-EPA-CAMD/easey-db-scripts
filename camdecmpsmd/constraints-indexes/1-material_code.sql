ALTER TABLE IF EXISTS camdecmpsmd.material_code
    ADD CONSTRAINT pk_material_code PRIMARY KEY (material_cd),
    ADD CONSTRAINT uq_material_code_description UNIQUE (material_code_description);
