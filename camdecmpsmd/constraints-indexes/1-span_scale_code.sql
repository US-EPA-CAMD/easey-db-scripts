ALTER TABLE IF EXISTS camdecmpsmd.span_scale_code
    ADD CONSTRAINT pk_span_scale_code PRIMARY KEY (span_scale_cd),
    ADD CONSTRAINT uq_span_scale_code_description UNIQUE (span_scale_cd_description);
