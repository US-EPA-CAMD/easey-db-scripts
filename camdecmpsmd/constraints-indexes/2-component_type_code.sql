ALTER TABLE IF EXISTS camdecmpsmd.component_type_code
    ADD CONSTRAINT pk_component_type_code PRIMARY KEY (component_type_cd),
    ADD CONSTRAINT uq_component_type_code_description UNIQUE (component_type_cd_description),
    ADD CONSTRAINT fk_component_type_code_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_component_type_code_parameter_cd
    ON camdecmpsmd.component_type_code USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);