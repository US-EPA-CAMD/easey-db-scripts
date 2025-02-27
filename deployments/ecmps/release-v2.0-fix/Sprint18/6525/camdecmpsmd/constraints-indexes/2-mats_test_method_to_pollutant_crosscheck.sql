ALTER TABLE IF EXISTS camdecmpsmd.mats_test_method_to_pollutant_crosscheck
    ADD CONSTRAINT pk_mats_test_method_to_pollutant_crosscheck PRIMARY KEY (mats_test_meth_cd, mats_pollutant_match),
    ADD CONSTRAINT fk_mats_test_method_to_pollutant_crosscheck_mats_test_method_cd FOREIGN KEY (mats_test_meth_cd) REFERENCES camdecmpsmd.mats_test_method_code (mats_test_meth_cd) MATCH simple,
    ADD CONSTRAINT fk_mats_test_method_to_pollutant_crosscheck_mats_pollutant_cd FOREIGN KEY (mats_pollutant_cd) REFERENCES camdecmpsmd.mats_pollutant_code (mats_pollutant_cd) MATCH simple;

