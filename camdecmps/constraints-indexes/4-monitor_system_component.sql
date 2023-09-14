ALTER TABLE IF EXISTS camdecmps.monitor_system_component
    ADD CONSTRAINT pk_monitor_system_component PRIMARY KEY (mon_sys_comp_id),
    ADD CONSTRAINT fk_monitor_system_component_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_component_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_system_component_mon_sys_id
    ON camdecmps.monitor_system_component USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_component_component_id
    ON camdecmps.monitor_system_component USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);
