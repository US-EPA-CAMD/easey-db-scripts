ALTER TABLE IF EXISTS camdecmpsmd.dm_emissions_user_code
    ADD CONSTRAINT pk_dm_emissions_user_code PRIMARY KEY (dm_emissions_user_cd),
    ADD CONSTRAINT uq_dm_emissions_user_code_description UNIQUE (dm_emissions_user_description);
