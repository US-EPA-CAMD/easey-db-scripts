ALTER TABLE IF EXISTS camdecmpsmd.system_parameter
    ADD CONSTRAINT pk_system_parameter PRIMARY KEY (sys_param_id),
    ADD CONSTRAINT fk_system_parameter_system_parameter_name FOREIGN KEY (sys_param_name)
        REFERENCES camdecmpsmd.system_parameter_name (sys_param_name) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_system_parameter_sys_param_name
    ON camdecmpsmd.system_parameter USING btree
    (sys_param_name COLLATE pg_catalog."default" ASC NULLS LAST);