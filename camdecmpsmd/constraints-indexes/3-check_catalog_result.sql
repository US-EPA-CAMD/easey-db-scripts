ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_result
    ADD CONSTRAINT pk_check_catalog_result PRIMARY KEY (check_catalog_result_id);

CREATE INDEX IF NOT EXISTS idx_check_catalog_result_check_catalog_id
    ON camdecmpsmd.check_catalog_result USING btree
    (check_catalog_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_result_response_catalog_id
    ON camdecmpsmd.check_catalog_result USING btree
    (response_catalog_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_result_severity_cd
    ON camdecmpsmd.check_catalog_result USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);
