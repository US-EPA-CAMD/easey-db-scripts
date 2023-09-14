ALTER TABLE IF EXISTS camdecmpsmd.es_match_data_type_code
    ADD CONSTRAINT pk_es_match_data_type_code PRIMARY KEY (es_match_data_type_cd),
    ADD CONSTRAINT uq_es_match_data_type_code_description UNIQUE (es_match_data_type_description)
    ADD CONSTRAINT uq_es_match_data_type_code_label UNIQUE (es_match_data_type_label);
