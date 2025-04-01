CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_test_method_to_pollutant_crosscheck (
    mats_test_meth_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_pollutant_cd varchar(7) COLLATE pg_catalog."default",
    mats_pollutant_match varchar(7) COLLATE pg_catalog."default" GENERATED ALWAYS AS (coalesce(mats_pollutant_cd, 'ANY')) STORED
);

COMMENT ON TABLE camdecmpsmd.mats_test_method_to_pollutant_crosscheck IS 'Defines the relationships between MATS Test Methods and Pollutants.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_to_pollutant_crosscheck.mats_test_meth_cd IS 'Foreign key to the MATS Test Method Code table.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_to_pollutant_crosscheck.mats_pollutant_cd IS 'Foreign key to the MATS Pollutant Code table.';

COMMENT ON COLUMN camdecmpsmd.mats_test_method_to_pollutant_crosscheck.mats_pollutant_match IS 'A generated column used to match test methods to any pollutant when the pollutant code is null.';

