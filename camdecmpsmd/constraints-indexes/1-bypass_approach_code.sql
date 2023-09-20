ALTER TABLE IF EXISTS camdecmpsmd.bypass_approach_code
    ADD CONSTRAINT pk_bypass_approach_code PRIMARY KEY (bypass_approach_cd),
    ADD CONSTRAINT uq_bypass_approach_code_description UNIQUE (bypass_approach_cd_description);
