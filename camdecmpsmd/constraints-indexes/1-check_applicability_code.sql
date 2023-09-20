ALTER TABLE IF EXISTS camdecmpsmd.check_applicability_code
    ADD CONSTRAINT pk_check_applicability_code PRIMARY KEY (check_applicability_cd),
    ADD CONSTRAINT uq_check_applicability_code_name UNIQUE (check_applicability_cd_name);
