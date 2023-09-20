ALTER TABLE IF EXISTS camdecmps.summary_value
    ADD CONSTRAINT pk_summary_value PRIMARY KEY (sum_value_id),
    ADD CONSTRAINT uq_summary_value UNIQUE (mon_loc_id, rpt_period_id, parameter_cd),
    ADD CONSTRAINT fk_summary_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_summary_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_summary_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_summary_value_mon_loc_id
    ON camdecmps.summary_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_parameter_cd
    ON camdecmps.summary_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_rpt_period_id
    ON camdecmps.summary_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_rpt_period_id_mon_loc_id
    ON camdecmps.summary_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
