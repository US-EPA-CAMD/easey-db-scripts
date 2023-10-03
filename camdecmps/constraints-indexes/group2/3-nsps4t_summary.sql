ALTER TABLE IF EXISTS camdecmps.nsps4t_summary
    ADD CONSTRAINT pk_nsps4t_summary PRIMARY KEY (nsps4t_sum_id, rpt_period_id),
    ADD CONSTRAINT fk_nsps4t_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_electrical_load_code FOREIGN KEY (electrical_load_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_emission_standard_code FOREIGN KEY (emission_standard_cd)
        REFERENCES camdecmpsmd.nsps4t_emission_standard_code (emission_standard_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_units_of_measure_code FOREIGN KEY (modus_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_mon_loc_id
    ON camdecmps.nsps4t_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_electrical_load_cd
    ON camdecmps.nsps4t_summary USING btree
    (electrical_load_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_rpt_period_id
    ON camdecmps.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_emission_standard_cd
    ON camdecmps.nsps4t_summary USING btree
    (emission_standard_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_modus_uom_cd
    ON camdecmps.nsps4t_summary USING btree
    (modus_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
