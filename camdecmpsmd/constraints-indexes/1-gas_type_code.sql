ALTER TABLE IF EXISTS camdecmpsmd.gas_type_code
    ADD CONSTRAINT pk_gas_type_code PRIMARY KEY (gas_type_cd),
    ADD CONSTRAINT uq_gas_type_code_description UNIQUE (gas_type_description);
