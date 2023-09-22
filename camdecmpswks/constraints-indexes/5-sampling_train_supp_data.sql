ALTER TABLE IF EXISTS camdecmpswks.sampling_train_supp_data
	  ADD CONSTRAINT pk_sampling_train_supp_data PRIMARY KEY (trap_train_id),
    ADD CONSTRAINT fk_sampling_train_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_test_result_code FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_train_qa_status_code FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_supp_data_sorbent_trap_supp_data FOREIGN KEY (trap_id)
        REFERENCES camdecmpswks.sorbent_trap_supp_data (trap_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_trap_id
    ON camdecmpswks.sampling_train_supp_data USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_component_id
    ON camdecmpswks.sampling_train_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_mon_loc_id
    ON camdecmpswks.sampling_train_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_rpt_period_id
    ON camdecmpswks.sampling_train_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_sampling_ratio_test_result_cd
    ON camdecmpswks.sampling_train_supp_data USING btree
    (sampling_ratio_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_train_qa_status_cd
    ON camdecmpswks.sampling_train_supp_data USING btree
    (train_qa_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_rpt_period_id_mon_loc_id
    ON camdecmpswks.sampling_train_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
