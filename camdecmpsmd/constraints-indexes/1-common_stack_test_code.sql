ALTER TABLE IF EXISTS camdecmpsmd.common_stack_test_code
    ADD CONSTRAINT pk_common_stack_test_code PRIMARY KEY (common_stack_test_cd),
    ADD CONSTRAINT uq_common_stack_test_code_description UNIQUE (common_stack_test_cd_description);
