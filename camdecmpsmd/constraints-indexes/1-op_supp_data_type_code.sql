ALTER TABLE IF EXISTS camdecmpsmd.op_supp_data_type_code
    ADD CONSTRAINT pk_op_supp_data_type_code PRIMARY KEY (op_supp_data_type_cd),
    ADD CONSTRAINT uq_op_supp_data_type_code_description UNIQUE (op_supp_data_type_description);
