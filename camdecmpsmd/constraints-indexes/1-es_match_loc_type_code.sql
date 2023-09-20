ALTER TABLE IF EXISTS camdecmpsmd.es_match_loc_type_code
    ADD CONSTRAINT pk_es_match_loc_type_code PRIMARY KEY (es_match_loc_type_cd),
    ADD CONSTRAINT uq_es_match_loc_type_code_description UNIQUE (es_match_loc_type_description);
