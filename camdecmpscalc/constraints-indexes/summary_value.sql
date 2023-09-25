ALTER TABLE IF EXISTS camdecmpscalc.summary_value
    ADD CONSTRAINT pk_summary_value PRIMARY KEY (pk),
    ADD CONSTRAINT fk_summary_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_summary_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_summary_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
   	ADD CONSTRAINT fk_summary_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_summary_value_chk_session_id
    ON camdecmpscalc.summary_value USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_trap_id
    ON camdecmpscalc.summary_value USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_rpt_period_id
    ON camdecmpscalc.summary_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_parameter_cd
    ON camdecmpscalc.summary_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_mon_loc_id
    ON camdecmpscalc.summary_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
