ALTER TABLE IF EXISTS camdecmpsmd.op_date_code
    ADD CONSTRAINT pk_op_date_code PRIMARY KEY (op_date_cd),
    ADD CONSTRAINT uq_op_date_code_description UNIQUE (op_date_cd_description);
