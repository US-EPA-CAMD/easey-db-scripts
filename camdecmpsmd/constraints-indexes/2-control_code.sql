ALTER TABLE IF EXISTS camdecmpsmd.control_code
    ADD CONSTRAINT pk_control_code PRIMARY KEY (control_cd),
    ADD CONSTRAINT uq_control_code_description UNIQUE (control_description),
    ADD CONSTRAINT fk_control_code_control_equip_param_code FOREIGN KEY (control_equip_param_cd)
        REFERENCES camdecmpsmd.control_equip_param_code (control_equip_param_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_control_code_control_equip_param_cd
    ON camdecmpsmd.control_code USING btree
    (control_equip_param_cd COLLATE pg_catalog."default" ASC NULLS LAST);
