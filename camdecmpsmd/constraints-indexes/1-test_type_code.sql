ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    ADD CONSTRAINT pk_test_type_code PRIMARY KEY (test_type_cd),
    ADD CONSTRAINT uq_test_type_code_description UNIQUE (test_type_cd_description),
    ADD CONSTRAINT fk_test_type_code_group_code FOREIGN KEY (group_cd)
        REFERENCES camdecmpsmd.test_type_group_code (test_type_group_cd) MATCH SIMPLE;

CREATE INDEX idx_test_type_code_group_cd
    ON camdecmpsmd.test_type_code USING btree
    (group_cd COLLATE pg_catalog."default" ASC NULLS LAST);