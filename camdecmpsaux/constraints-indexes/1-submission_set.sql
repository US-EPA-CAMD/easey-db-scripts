ALTER TABLE IF EXISTS camdecmpsaux.submission_set
    ADD CONSTRAINT pk_submission_set PRIMARY KEY (submission_set_id),
    ADD CONSTRAINT fk_submission_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_submission_set_mon_plan_id
    ON camdecmpsaux.submission_set USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_activity_id
    ON camdecmpsaux.submission_set USING btree
    (activity_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_status_cd
    ON camdecmpsaux.submission_set USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_fac_id
    ON camdecmpsaux.submission_set USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_oris_code
    ON camdecmpsaux.submission_set USING btree
    (oris_code ASC NULLS LAST);
