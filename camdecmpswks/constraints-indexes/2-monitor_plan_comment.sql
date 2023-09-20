ALTER TABLE IF EXISTS camdecmpswks.monitor_plan_comment
    ADD CONSTRAINT pk_monitor_plan_comment PRIMARY KEY (mon_plan_comment_id),
    ADD CONSTRAINT fk_monitor_plan_comment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_comment_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_comment_mon_plan_id
    ON camdecmpswks.monitor_plan_comment USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_comment_submission_availability_cd
    ON camdecmpswks.monitor_plan_comment USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);
