ALTER TABLE IF EXISTS camdecmpsmd.parameter_method_to_formula
    ADD CONSTRAINT pk_parameter_method_to_formula PRIMARY KEY (param_method_to_formula_id),
    ADD CONSTRAINT uq_parameter_method_to_formula UNIQUE (parameter_cd, method_cd, system_type_list, location_type_list),
    ADD CONSTRAINT fk_parameter_method_to_formula_method_code FOREIGN KEY (method_cd)
        REFERENCES camdecmpsmd.method_code (method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_parameter_method_to_formula_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_parameter_method_to_formula_method_cd
    ON camdecmpsmd.parameter_method_to_formula USING btree
    (method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_parameter_method_to_formula_parameter_cd
    ON camdecmpsmd.parameter_method_to_formula USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);