CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_data_file_type_code (
    mats_data_file_type_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_data_file_type_description varchar(100) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_data_file_type_code IS 'Lookup table for MATS data file types.';

COMMENT ON COLUMN camdecmpsmd.mats_data_file_type_code.mats_data_file_type_cd IS 'MATS data file type code.';

COMMENT ON COLUMN camdecmpsmd.mats_data_file_type_code.mats_data_file_type_description IS 'MATS data file type description.';

