ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_parameter
    ADD CONSTRAINT pk_check_catalog_parameter PRIMARY KEY (check_catalog_param_id),
    ADD CONSTRAINT fk_check_catalog_parameter_check_catalog FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_catalog_parameter_check_parameter_code FOREIGN KEY (check_param_id)
        REFERENCES camdecmpsmd.check_parameter_code (check_param_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_catalog_parameter_check_parameter_usage_code FOREIGN KEY (check_param_usage_cd)
        REFERENCES camdecmpsmd.check_parameter_usage_code (check_param_usage_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_catalog_parameter_check_catalog_id
    ON camdecmpsmd.check_catalog_parameter USING btree
    (check_catalog_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_parameter_check_param_id
    ON camdecmpsmd.check_catalog_parameter USING btree
    (check_param_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_parameter_check_param_usage_cd
    ON camdecmpsmd.check_catalog_parameter USING btree
    (check_param_usage_cd COLLATE pg_catalog."default" ASC NULLS LAST);
