ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
	  ADD CONSTRAINT pk_em_submission_access PRIMARY KEY (em_sub_access_id),
    ADD CONSTRAINT uq_em_submission_access UNIQUE (mon_plan_id, rpt_period_id, access_begin_date, access_end_date),
    ADD CONSTRAINT fk_em_submission_access_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_em_submission_access_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_em_status_code FOREIGN KEY (em_status_cd)
        REFERENCES camdecmpsmd.em_status_code (em_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_em_sub_type_code FOREIGN KEY (em_sub_type_cd)
        REFERENCES camdecmpsmd.em_sub_type_code (em_sub_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_submission_availability_code FOREIGN KEY (sub_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (sub_availability_cd) MATCH SIMPLE,
    ADD CONSTRAINT chk_em_submission_access_begin_date_lte_end_date CHECK (access_begin_date <= access_end_date);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_mon_plan_id
    ON camdecmpsaux.em_submission_access USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_em_status_cd
    ON camdecmpsaux.em_submission_access USING btree
    (em_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_em_sub_type_cd
    ON camdecmpsaux.em_submission_access USING btree
    (em_sub_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_rpt_period_id
    ON camdecmpsaux.em_submission_access USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_sub_availability_cd
    ON camdecmpsaux.em_submission_access USING btree
    (sub_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_rpt_period_id_mon_plan_id
    ON camdecmpsaux.em_submission_access USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
