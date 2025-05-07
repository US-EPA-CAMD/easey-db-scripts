ALTER TABLE IF EXISTS camdecmpsmd.mats_test_method_code
    ADD CONSTRAINT pk_mats_test_method_code PRIMARY KEY (mats_test_meth_cd),
    ADD CONSTRAINT uq_mats_test_method_code_1 UNIQUE (mats_test_meth_description),
    ADD CONSTRAINT uq_mats_test_method_code_2 UNIQUE (display_order);

