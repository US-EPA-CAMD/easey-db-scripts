ALTER TABLE IF EXISTS camdecmpswks.component_op_supp_data
    ADD CONSTRAINT pk_component_op_supp_data PRIMARY KEY (comp_op_supp_data_id),
    ADD CONSTRAINT fk_component_op_supp_data_cod FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_op_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_component_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_component_op_supp_data_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_component_id
    ON camdecmpswks.component_op_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_op_supp_data_type_cd
    ON camdecmpswks.component_op_supp_data USING btree
    (op_supp_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_rpt_period_id
    ON camdecmpswks.component_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_mon_loc_id
    ON camdecmpswks.component_op_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_rpt_period_id_mon_loc_id
    ON camdecmpswks.component_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
