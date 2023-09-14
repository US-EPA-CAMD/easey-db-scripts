CREATE TABLE IF NOT EXISTS camdecmpsmd.file_type_code
(
    file_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    file_type_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.file_type_code
    IS 'Lookup table for the distinct types of submissions allowed by the host.';

COMMENT ON COLUMN camdecmpsmd.file_type_code.file_type_cd
    IS ' Code used to identify the file type.';

COMMENT ON COLUMN camdecmpsmd.file_type_code.file_type_cd_description
    IS ' Description of lookup code.';