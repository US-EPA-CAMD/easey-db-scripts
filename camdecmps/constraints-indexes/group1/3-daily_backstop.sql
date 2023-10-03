ALTER TABLE IF EXISTS camdecmps.daily_backstop
    ADD CONSTRAINT pk_daily_backstop PRIMARY KEY (daily_backstop_id, rpt_period_id),
    ADD CONSTRAINT fk_daily_backstop_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_backstop_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_backstop_unit_id
    ON camdecmps.daily_backstop USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_mon_loc_id
    ON camdecmps.daily_backstop USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_rpt_period_id
    ON camdecmps.daily_backstop USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_rpt_period_id_mon_loc_id
    ON camdecmps.daily_backstop USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
