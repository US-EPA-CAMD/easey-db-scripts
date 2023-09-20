ALTER TABLE IF EXISTS camdecmpsmd.ref_method_code
    ADD CONSTRAINT pk_ref_method_code PRIMARY KEY (ref_method_cd),
    ADD CONSTRAINT uq_ref_method_code_description UNIQUE (ref_method_cd_description);

CREATE INDEX IF NOT EXISTS idx_ref_method_code_parameter_cd
    ON camdecmpsmd.ref_method_code USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
