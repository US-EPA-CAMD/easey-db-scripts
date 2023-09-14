ALTER TABLE IF EXISTS camdecmps.sorbent_trap_supp_data
    ADD CONSTRAINT pk_st_supp_data PRIMARY KEY (trap_id),
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_aps_cd FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_modc_cd FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_modc_cd
    ON camdecmps.sorbent_trap_supp_data USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_mon_loc_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_mon_sys_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_rpt_period_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
