ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission_test_method
    ADD CONSTRAINT pk_mats_data_submission_test_method PRIMARY KEY (mats_data_sub_test_method_id),
    ADD CONSTRAINT fk_mats_data_submission_test_method_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_test_method_mats_test_method_code FOREIGN KEY (mats_test_meth_cd) REFERENCES camdecmpsmd.mats_test_method_code (mats_test_meth_cd) MATCH simple;

