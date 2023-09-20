ALTER TABLE IF EXISTS camdmd.transaction_type_code
    ADD CONSTRAINT pk_transaction_type_code PRIMARY KEY (trans_type_cd),
    ADD CONSTRAINT uq_transaction_type_code_description UNIQUE (trans_type_description);
