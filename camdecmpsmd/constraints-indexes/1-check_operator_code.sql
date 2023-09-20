ALTER TABLE IF EXISTS camdecmpsmd.check_operator_code
    ADD CONSTRAINT pk_check_operator_code PRIMARY KEY (check_operator_cd),
    ADD CONSTRAINT uq_check_operator_code_name UNIQUE (check_operator_cd_name);
