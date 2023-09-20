ALTER TABLE IF EXISTS camdecmpsmd.waf_method_code
    ADD CONSTRAINT pk_waf_method_code PRIMARY KEY (waf_method_cd),
    ADD CONSTRAINT uq_waf_method_code_description UNIQUE (waf_method_cd_description);
