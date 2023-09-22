ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file
    ADD CONSTRAINT pk_mats_bulk_file PRIMARY KEY (mats_bulk_file_id),
    ADD CONSTRAINT fk_mats_bulk_file_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_bulk_file_test_type_code FOREIGN KEY (test_type_code)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_bulk_file_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_bulk_file_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_fac_id
    ON camdecmpswks.mats_bulk_file USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_test_type_code
    ON camdecmpswks.mats_bulk_file USING btree
    (test_type_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_mon_plan_id
    ON camdecmpswks.mats_bulk_file USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_test_num
    ON camdecmpswks.mats_bulk_file USING btree
    (test_num COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_filename
    ON camdecmpswks.mats_bulk_file USING btree
    (filename COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_submission_id
    ON camdecmpswks.mats_bulk_file USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_submission_availability_cd
    ON camdecmpswks.mats_bulk_file USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_bulk_file_eval_status_cd
    ON camdecmpswks.mats_bulk_file USING btree
    (eval_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
