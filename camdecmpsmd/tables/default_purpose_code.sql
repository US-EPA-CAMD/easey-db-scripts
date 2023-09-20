CREATE TABLE IF NOT EXISTS camdecmpsmd.default_purpose_code
(
    default_purpose_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    def_purpose_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.default_purpose_code
    IS 'Lookup table of codes identifying the purpose of the default value.  Record Type 531.';

COMMENT ON COLUMN camdecmpsmd.default_purpose_code.default_purpose_cd
    IS 'Code used to identify the purpose or intended use of defaults, maximums and constants. ';

COMMENT ON COLUMN camdecmpsmd.default_purpose_code.def_purpose_cd_description
    IS 'Description of lookup code. ';