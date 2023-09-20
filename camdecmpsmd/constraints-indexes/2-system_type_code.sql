ALTER TABLE IF EXISTS camdecmpsmd.system_type_code
    ADD CONSTRAINT pk_system_type_code PRIMARY KEY (sys_type_cd),
    ADD CONSTRAINT uq_system_type_code_description UNIQUE (sys_type_description),
    ADD CONSTRAINT fk_system_type_code_parameter_cd FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_system_type_code_parameter_cd
    ON camdecmpsmd.system_type_code USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
