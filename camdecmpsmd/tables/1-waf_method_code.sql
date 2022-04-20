-- Table: camdecmpsmd.waf_method_code

-- DROP TABLE camdecmpsmd.waf_method_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.waf_method_code
(
    waf_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    waf_method_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_waf_method_code PRIMARY KEY (waf_method_cd)
);

COMMENT ON TABLE camdecmpsmd.waf_method_code
    IS 'Lookup table for wall effects adjustment factor method code.';

COMMENT ON COLUMN camdecmpsmd.waf_method_code.waf_method_cd
    IS 'Code used to identify the WAF determination method. ';

COMMENT ON COLUMN camdecmpsmd.waf_method_code.waf_method_cd_description
    IS 'Description of lookup code. ';