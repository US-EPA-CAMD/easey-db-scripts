ALTER TABLE IF EXISTS camdecmpswks.daily_fuel
    ADD CONSTRAINT pk_daily_fuel PRIMARY KEY (daily_fuel_id),
    ADD CONSTRAINT fk_daily_fuel_daily_emission FOREIGN KEY (daily_emission_id)
        REFERENCES camdecmpswks.daily_emission (daily_emission_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_fuel_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_fuel_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_fuel_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_fuel_daily_emission_id
    ON camdecmpswks.daily_fuel USING btree
    (daily_emission_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_fuel_cd
    ON camdecmpswks.daily_fuel USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_mon_loc_id
    ON camdecmpswks.daily_fuel USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_rpt_period_id
    ON camdecmpswks.daily_fuel USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_rpt_period_id_mon_loc_id
    ON camdecmpswks.daily_fuel USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
