ALTER TABLE IF EXISTS camdecmpswks.last_qa_value_supp_data
    ADD CONSTRAINT pk_last_qa_value_supp_data PRIMARY KEY (last_qa_value_supp_data_id),
    ADD CONSTRAINT fk_last_qa_value_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_ht FOREIGN KEY (hourly_type_cd)
        REFERENCES camdecmpsmd.hourly_type_code (hourly_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_pc FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_pr FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_component_id
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_mon_loc_id
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_mon_sys_id
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_parameter_cd
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_hourly_type_cd
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (hourly_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_rpt_period_id
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_rpt_period_id_mon_loc_id
    ON camdecmpswks.last_qa_value_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
