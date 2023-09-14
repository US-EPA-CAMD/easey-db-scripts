ALTER TABLE IF EXISTS camdecmpsmd.accuracy_test_method_code
    ADD CONSTRAINT pk_accuracy_test_method_code PRIMARY KEY (acc_test_method_cd),
    ADD CONSTRAINT uq_accuracy_test_method_code_description UNIQUE (acc_test_method_cd_description);