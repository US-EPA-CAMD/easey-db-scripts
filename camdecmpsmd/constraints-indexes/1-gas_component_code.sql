ALTER TABLE IF EXISTS camdecmpsmd.gas_component_code
    ADD CONSTRAINT pk_gas_component_code PRIMARY KEY (gas_component_cd),
    ADD CONSTRAINT uq_gas_component_code_description UNIQUE (gas_component_description);
