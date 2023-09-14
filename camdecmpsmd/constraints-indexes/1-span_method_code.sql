ALTER TABLE IF EXISTS camdecmpsmd.span_method_code
    ADD CONSTRAINT pk_span_method_code PRIMARY KEY (span_method_cd),
    ADD CONSTRAINT uq_span_method_code_description UNIQUE (span_method_cd_description);
