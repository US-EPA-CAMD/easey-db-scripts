ALTER TABLE IF EXISTS camdecmpsmd.check_operator_data_type
    ADD CONSTRAINT pk_check_operator_data_type PRIMARY KEY (check_operator_cd, check_data_type_cd),
    ADD CONSTRAINT fk_check_operator_data_type_check_data_type_code FOREIGN KEY (check_data_type_cd)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_operator_data_type_check_operator_code FOREIGN KEY (check_operator_cd)
        REFERENCES camdecmpsmd.check_operator_code (check_operator_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_operator_data_type_check_operator_cd
    ON camdecmpsmd.check_operator_data_type USING btree
    (check_operator_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_operator_data_type_check_data_type_cd
    ON camdecmpsmd.check_operator_data_type USING btree
    (check_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
