ALTER TABLE IF EXISTS camdecmpswks.sampling_train
    ADD CONSTRAINT pk_sampling_train PRIMARY KEY (trap_train_id),
    ADD CONSTRAINT fk_sampling_train_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_sorbent_trap FOREIGN KEY (trap_id)
        REFERENCES camdecmpswks.sorbent_trap (trap_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_test_result_code_post_leak FOREIGN KEY (post_leak_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_test_result_code_sampling_ratio FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_train_qa_status_code FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sampling_train_trap_id
    ON camdecmpswks.sampling_train USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_mon_loc_id
    ON camdecmpswks.sampling_train USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_rpt_period_id
    ON camdecmpswks.sampling_train USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_component_id
    ON camdecmpswks.sampling_train USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_sampling_ratio_test_result_cd
    ON camdecmpswks.sampling_train USING btree
    (sampling_ratio_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_post_leak_test_result_cd
    ON camdecmpswks.sampling_train USING btree
    (post_leak_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_train_qa_status_cd
    ON camdecmpswks.sampling_train USING btree
    (train_qa_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_rpt_period_id_mon_loc_id
    ON camdecmpswks.sampling_train USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
