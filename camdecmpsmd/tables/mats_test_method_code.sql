CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_test_method_code (
    mats_test_meth_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_test_meth_description varchar(100) COLLATE pg_catalog."default" NOT NULL,
    display_order smallint NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_test_method_code IS 'Lookup table for MATS test methods.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_code.mats_test_meth_cd IS 'Test method code.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_code.mats_test_meth_description IS 'Test method description.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_code.display_order IS 'Indicates the order in which test methods should display.';

