CREATE TABLE IF NOT EXISTS camdecmpsmd.operating_level_code
(
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_level_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.operating_level_code
    IS 'Lookup table of operating levels.';

COMMENT ON COLUMN camdecmpsmd.operating_level_code.op_level_cd
    IS 'Code used to identify the operating level. ';

COMMENT ON COLUMN camdecmpsmd.operating_level_code.op_level_cd_description
    IS 'Description of operating level code. ';