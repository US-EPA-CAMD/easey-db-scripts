ALTER TABLE IF EXISTS camdecmpscalc.component_op_supp_data
    ADD CONSTRAINT pk_component_op_supp_data PRIMARY KEY (pk),
    ADD CONSTRAINT fk_component_op_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_component_op_supp_data_op_supp_data_type_code FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_op_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_component_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_component_op_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_chk_session_id
    ON camdecmpscalc.component_op_supp_data USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_cal_inj_id
    ON camdecmpscalc.component_op_supp_data USING btree
    (cal_inj_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_component_id
    ON camdecmpscalc.component_op_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_rpt_period_id
    ON camdecmpscalc.component_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_op_supp_data_type_cd
    ON camdecmpscalc.component_op_supp_data USING btree
    (op_supp_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_mon_loc_id
    ON camdecmpscalc.component_op_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
