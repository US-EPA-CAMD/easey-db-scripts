ALTER TABLE IF EXISTS camdecmpsmd.category_code
    ADD CONSTRAINT pk_category_code PRIMARY KEY (category_cd),
    ADD CONSTRAINT uq_category_code_description UNIQUE (category_cd_description)
    ADD CONSTRAINT fk_category_code_process_code FOREIGN KEY (process_cd)
        REFERENCES camdecmpsmd.process_code (process_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_category_code_es_match_loc_type_code FOREIGN KEY (es_match_loc_type_cd)
        REFERENCES camdecmpsmd.es_match_loc_type_code (es_match_loc_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_category_code_es_match_data_type_code FOREIGN KEY (es_match_data_type_cd)
        REFERENCES camdecmpsmd.es_match_data_type_code (es_match_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_category_code_es_match_time_type_code FOREIGN KEY (es_match_time_type_cd)
        REFERENCES camdecmpsmd.es_match_time_type_code (es_match_time_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_category_code_process_cd
    ON camdecmpsmd.category_code USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_category_code_es_match_loc_type_cd
    ON camdecmpsmd.category_code USING btree
    (es_match_loc_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_category_code_es_match_data_type_cd
    ON camdecmpsmd.category_code USING btree
    (es_match_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_category_code_es_match_time_type_cd
    ON camdecmpsmd.category_code USING btree
    (es_match_time_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
