ALTER TABLE IF EXISTS camdecmps.nsps4t_compliance_period
    ADD CONSTRAINT pk_nsps4t_compliance_period PRIMARY KEY (nsps4t_cmp_id, rpt_period_id),
    ADD CONSTRAINT fk_nsps4t_compliance_period_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_nsps4t_summary FOREIGN KEY (nsps4t_sum_id, rpt_period_id)
        REFERENCES camdecmps.nsps4t_summary (nsps4t_sum_id, rpt_period_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_units_of_measure_code FOREIGN KEY (co2_emission_rate_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_mon_loc_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_rpt_period_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_nsps4t_sum_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_co2_emission_rate_uom_cd
    ON camdecmps.nsps4t_compliance_period USING btree
    (co2_emission_rate_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
