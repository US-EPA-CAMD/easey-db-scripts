ALTER TABLE IF EXISTS camdecmpswks.monitor_hrly_value
    ADD CONSTRAINT pk_monitor_hrly_value PRIMARY KEY (monitor_hrly_val_id),
    ADD CONSTRAINT fk_monitor_hrly_value_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_hour_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_mon_sys_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_component_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_parameter_cd
    ON camdecmpswks.monitor_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_modc_cd
    ON camdecmpswks.monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_rpt_period_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_mon_loc_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmpswks.monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_
    ON camdecmpswks.monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_
    ON camdecmpswks.monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
