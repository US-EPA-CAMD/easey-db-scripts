ALTER TABLE IF EXISTS camdecmpsmd.system_designation_code
    ADD CONSTRAINT pk_system_designation_code PRIMARY KEY (sys_designation_cd),
    ADD CONSTRAINT uq_system_designation_code_description UNIQUE (sys_designation_cd_description);
