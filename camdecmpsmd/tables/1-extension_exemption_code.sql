-- Table: camdecmpsmd.extension_exemption_code

-- DROP TABLE camdecmpsmd.extension_exemption_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.extension_exemption_code
(
    extens_exempt_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    extens_exemp_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_extension_exemption_code PRIMARY KEY (extens_exempt_cd)
);

COMMENT ON TABLE camdecmpsmd.extension_exemption_code
    IS 'Lookup table of codes indicating type of test extension or exemption.';

COMMENT ON COLUMN camdecmpsmd.extension_exemption_code.extens_exempt_cd
    IS 'Code used to identify the extension or exemption. ';

COMMENT ON COLUMN camdecmpsmd.extension_exemption_code.extens_exemp_cd_description
    IS 'Description of lookup code. ';