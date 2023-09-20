CREATE TABLE IF NOT EXISTS camdecmpsmd.qual_data_type_code
(
    qual_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qual_data_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.qual_data_type_code
    IS 'Lookup table for type of data used to determine special exemptions and /or qualifications.';

COMMENT ON COLUMN camdecmpsmd.qual_data_type_code.qual_data_type_cd
    IS 'Code used to indicate type of data for year (actual or projected) used to determine peaking or gas-fired qualification. ';

COMMENT ON COLUMN camdecmpsmd.qual_data_type_code.qual_data_type_cd_description
    IS 'Description of lookup code. ';