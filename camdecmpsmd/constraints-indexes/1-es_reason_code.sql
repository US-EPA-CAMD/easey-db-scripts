ALTER TABLE IF EXISTS camdecmpsmd.es_reason_code
    ADD CONSTRAINT pk_es_reason_code PRIMARY KEY (es_reason_cd),
    ADD CONSTRAINT uq_es_reason_code_description UNIQUE (es_reason_description);
