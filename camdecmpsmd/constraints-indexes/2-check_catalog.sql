ALTER TABLE IF EXISTS camdecmpsmd.check_catalog
    ADD CONSTRAINT pk_check_catalog PRIMARY KEY (check_catalog_id),
    ADD CONSTRAINT uq_check_catalog_type_number UNIQUE (check_type_cd, check_number),
    ADD CONSTRAINT fk_check_catalog_check_type_code FOREIGN KEY (check_type_cd)
        REFERENCES camdecmpsmd.check_type_code (check_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_catalog_check_applicability_code FOREIGN KEY (check_applicability_cd)
        REFERENCES camdecmpsmd.check_applicability_code (check_applicability_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_catalog_check_status_code FOREIGN KEY (check_status_cd)
        REFERENCES camdecmpsmd.check_status_code (check_status_cd) MATCH SIMPLE;

CREATE INDEX idx_check_catalog_check_type_cd
    ON camdecmpsmd.check_catalog USING btree
    (check_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_check_catalog_check_number
    ON camdecmpsmd.check_catalog USING btree
    (check_number ASC NULLS LAST);

CREATE INDEX idx_check_catalog_check_applicability_cd
    ON camdecmpsmd.check_catalog USING btree
    (check_applicability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_check_catalog_check_status_cd
    ON camdecmpsmd.check_catalog USING btree
    (check_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_check_catalog_test_status_cd
    ON camdecmpsmd.check_catalog USING btree
    (test_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_check_catalog_code_status_cd
    ON camdecmpsmd.check_catalog USING btree
    (code_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
