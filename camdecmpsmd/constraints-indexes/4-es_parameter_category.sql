ALTER TABLE IF EXISTS camdecmpsmd.es_parameter_category
    ADD CONSTRAINT pk_es_parameter_category PRIMARY KEY (category_cd, es_parameter_group_cd),
    ADD CONSTRAINT fk_es_parameter_category_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_parameter_category_es_parameter_group_code FOREIGN KEY (es_parameter_group_cd)
        REFERENCES camdecmpsmd.es_parameter_group_code (es_parameter_group_cd) MATCH SIMPLE;

CREATE INDEX idx_es_parameter_category_category_cd
    ON camdecmpsmd.es_parameter_category USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_es_parameter_category_es_parameter_group_cd
    ON camdecmpsmd.es_parameter_category USING btree
    (es_parameter_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);