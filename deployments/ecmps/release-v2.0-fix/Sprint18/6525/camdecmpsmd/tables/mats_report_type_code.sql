CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_report_type_code (
    mats_rpt_type_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_rpt_type_description varchar(100) COLLATE pg_catalog."default" NOT NULL,
    metadata_rpt_type_cd varchar(12) COLLATE pg_catalog."default" NOT NULL,
    requires_pollutant boolean NOT NULL,
    requires_test_method boolean NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_report_type_code IS 'Lookup table for MATS report types.';

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.mats_rpt_type_cd IS 'Report type code.';

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.mats_rpt_type_description IS 'Report type description.';

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.metadata_rpt_type_cd IS 'Report type code to use in the metadata XML.';

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.requires_pollutant IS 'Flag indicating whether the selection of a pollutant is required.';

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.requires_test_method IS 'Flag indicating whether the selection of a test method is required.';

