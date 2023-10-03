ALTER TABLE IF EXISTS camdecmps.nsps4t_annual
    ADD CONSTRAINT pk_nsps4t_annual PRIMARY KEY (nsps4t_ann_id, rpt_period_id),
    ADD CONSTRAINT fk_nsps4t_annual_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_electrical_load_code FOREIGN KEY (annual_energy_sold_type_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_summary FOREIGN KEY (nsps4t_sum_id, rpt_period_id)
        REFERENCES camdecmps.nsps4t_summary (nsps4t_sum_id, rpt_period_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_annual_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_mon_loc_id
    ON camdecmps.nsps4t_annual USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_rpt_period_id
    ON camdecmps.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_nsps4t_sum_id
    ON camdecmps.nsps4t_annual USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_annual_energy_sold_type_cd
    ON camdecmps.nsps4t_annual USING btree
    (annual_energy_sold_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
