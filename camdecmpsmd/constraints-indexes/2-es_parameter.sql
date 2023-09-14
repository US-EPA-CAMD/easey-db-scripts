ALTER TABLE IF EXISTS camdecmpsmd.es_parameter
    ADD CONSTRAINT pk_es_parameter PRIMARY KEY (es_parameter_group_cd, parameter_cd),
    ADD CONSTRAINT fk_es_parameter_es_parameter_group_code FOREIGN KEY (es_parameter_group_cd)
        REFERENCES camdecmpsmd.es_parameter_group_code (es_parameter_group_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_parameter_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX idx_es_parameter_es_parameter_group_cd
    ON camdecmpsmd.es_parameter USING btree
    (es_parameter_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_es_parameter_parameter_cd
    ON camdecmpsmd.es_parameter USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);