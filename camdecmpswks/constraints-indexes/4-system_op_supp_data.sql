ALTER TABLE IF EXISTS camdecmpswks.system_op_supp_data
    ADD CONSTRAINT pk_system_op_supp_data PRIMARY KEY (sys_op_supp_data_id),
    ADD CONSTRAINT fk_system_op_supp_data_cod FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_system_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_system_op_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_system_op_supp_data_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_op_supp_data_type_cd
    ON camdecmpswks.system_op_supp_data USING btree
    (op_supp_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_mon_loc_id
    ON camdecmpswks.system_op_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_rpt_period_id
    ON camdecmpswks.system_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_mon_sys_id
    ON camdecmpswks.system_op_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_rpt_period_id_mon_loc_id
    ON camdecmpswks.system_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
