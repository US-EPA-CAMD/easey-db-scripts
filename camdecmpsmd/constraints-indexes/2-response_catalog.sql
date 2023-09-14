ALTER TABLE IF EXISTS camdecmpsmd.response_catalog
    ADD CONSTRAINT pk_response_catalog PRIMARY KEY (response_catalog_id),
    ADD CONSTRAINT fk_response_catalog_response_type_code FOREIGN KEY (response_type_cd)
        REFERENCES camdecmpsmd.response_type_code (response_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_response_catalog_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_response_catalog_response_type_cd
    ON camdecmpsmd.response_catalog USING btree
    (response_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_response_catalog_severity_cd
    ON camdecmpsmd.response_catalog USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);