ALTER TABLE IF EXISTS camdecmpsmd.check_parameter_code
    ADD CONSTRAINT pk_check_parameter_code PRIMARY KEY (check_param_id),
    ADD CONSTRAINT uq_check_parameter_code_name UNIQUE (check_param_id_name),
    ADD CONSTRAINT fk_check_parameter_code_check_data_type_code FOREIGN KEY (check_data_type_cd)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_parameter_code_check_parameter_type_code FOREIGN KEY (chk_param_type_cd)
        REFERENCES camdecmpsmd.check_parameter_type_code (chk_param_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_parameter_code_check_param_id_name
    ON camdecmpsmd.check_parameter_code USING btree
    (check_param_id_name COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_parameter_code_check_data_type_cd
    ON camdecmpsmd.check_parameter_code USING btree
    (check_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_parameter_code_chk_param_type_cd
    ON camdecmpsmd.check_parameter_code USING btree
    (chk_param_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
