ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	  ADD CONSTRAINT pk_es_spec PRIMARY KEY (es_spec_id),
    ADD CONSTRAINT fk_es_spec_check_catalog_result FOREIGN KEY (check_catalog_result_id)
        REFERENCES camdecmpsmd.check_catalog_result (check_catalog_result_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_match_data_type_code FOREIGN KEY (es_match_data_type_cd)
        REFERENCES camdecmpsmd.es_match_data_type_code (es_match_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_reason_code FOREIGN KEY (es_reason_cd)
        REFERENCES camdecmpsmd.es_reason_code (es_reason_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_match_time_type_code FOREIGN KEY (es_match_time_type_cd)
        REFERENCES camdecmpsmd.es_match_time_type_code (es_match_time_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_es_spec_check_catalog_result_id
    ON camdecmpsaux.es_spec USING btree
    (check_catalog_result_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_severity_cd
    ON camdecmpsaux.es_spec USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_fac_id
    ON camdecmpsaux.es_spec USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_match_data_type_cd
    ON camdecmpsaux.es_spec USING btree
    (es_match_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_match_time_type_cd
    ON camdecmpsaux.es_spec USING btree
    (es_match_time_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_reason_cd
    ON camdecmpsaux.es_spec USING btree
    (es_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);
