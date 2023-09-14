ALTER TABLE IF EXISTS camdmd.account_type_group_code
    ADD CONSTRAINT pk_account_type_group_code PRIMARY KEY (account_type_group_cd),
    ADD CONSTRAINT uq_account_type_group_code_description UNIQUE (account_type_group_description);
