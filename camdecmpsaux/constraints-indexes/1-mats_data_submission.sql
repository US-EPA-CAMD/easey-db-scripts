ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission
    ADD CONSTRAINT pk_mats_data_submission PRIMARY KEY (mats_data_sub_id),
    ADD CONSTRAINT fk_mats_data_submission_monitor_location FOREIGN KEY (mon_loc_id) REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_mats_report_type_code FOREIGN KEY (mats_rpt_type_cd) REFERENCES camdecmpsaux.mats_report_type_code (mats_rpt_type_cd) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_mats_averaging_group_code FOREIGN KEY (mats_avg_group_cd) REFERENCES camdecmpsaux.mats_averaging_group_code (mats_avg_group_cd) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_monitor_plan FOREIGN KEY (mon_plan_id) REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH simple,
    ADD CONSTRAINT fk_mats_data_submission_mats_status_code FOREIGN KEY (mats_status_cd) REFERENCES camdecmpsaux.mats_status_code (mats_status_cd) MATCH simple;

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_mon_loc_id ON camdecmpsaux.mats_data_submission USING btree (mon_loc_id COLLATE pg_catalog."default" ASC nulls LAST);

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_1 ON camdecmpsaux.mats_data_submission USING btree (mon_loc_id COLLATE pg_catalog."default" ASC nulls LAST, test_number COLLATE pg_catalog."default" ASC nulls LAST);

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_fac_id ON camdecmpsaux.mats_data_submission USING btree (fac_id ASC nulls LAST);

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_mon_plan_id ON camdecmpsaux.mats_data_submission USING btree (mon_plan_id COLLATE pg_catalog."default" ASC nulls LAST);

