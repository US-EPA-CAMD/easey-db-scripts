ALTER TABLE IF EXISTS camdecmpswks.sorbent_trap
    ADD CONSTRAINT pk_sorbent_trap PRIMARY KEY (trap_id),
    ADD CONSTRAINT fk_sorbent_trap_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sorbent_trap_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sorbent_trap_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_sorbent_trap_aps_code FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_mon_loc_id
    ON camdecmpswks.sorbent_trap USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_rpt_period_id
    ON camdecmpswks.sorbent_trap USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_modc_cd
    ON camdecmpswks.sorbent_trap USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_sorbent_trap_aps_cd
    ON camdecmpswks.sorbent_trap USING btree
    (sorbent_trap_aps_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_mon_sys_id
    ON camdecmpswks.sorbent_trap USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_rpt_period_id_mon_loc_id
    ON camdecmpswks.sorbent_trap USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
