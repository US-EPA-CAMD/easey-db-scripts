ALTER TABLE IF EXISTS camdecmpsmd.control_equip_param_code
    ADD CONSTRAINT pk_control_equip_param_code PRIMARY KEY (control_equip_param_cd),
    ADD CONSTRAINT uq_control_equip_param_code_description UNIQUE (control_equip_param_desc);
