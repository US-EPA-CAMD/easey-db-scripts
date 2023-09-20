ALTER TABLE IF EXISTS camdecmpsmd.fuel_flow_period_code
    ADD CONSTRAINT pk_fuel_flow_period_code PRIMARY KEY (fuel_flow_period_cd),
    ADD CONSTRAINT uq_fuel_flow_period_code_description UNIQUE (ff_period_cd_description);
