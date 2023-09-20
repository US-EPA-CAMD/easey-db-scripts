ALTER TABLE IF EXISTS camdecmpsmd.gas_level_code
    ADD CONSTRAINT pk_gas_level_code PRIMARY KEY (gas_level_cd),
    ADD CONSTRAINT uq_gas_level_code_description UNIQUE (gas_level_description);
