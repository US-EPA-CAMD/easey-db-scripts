ALTER TABLE IF EXISTS camdecmps.dm_emissions
    ADD CONSTRAINT pk_dm_emissions PRIMARY KEY (dm_emissions_id),
    ADD CONSTRAINT uq_dm_emissions UNIQUE (mon_plan_id, rpt_period_id),
    ADD CONSTRAINT fk_dm_emissions_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_apportionment_type_code FOREIGN KEY (apportionment_type_cd)
        REFERENCES camdecmpsmd.apportionment_type_code (apportionment_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_dm_emissions_mon_plan_id
    ON camdecmps.dm_emissions USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_rpt_period_id
    ON camdecmps.dm_emissions USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_apportionment_type_cd
    ON camdecmps.dm_emissions USING btree
    (apportionment_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_fac_id
    ON camdecmps.dm_emissions USING btree
    (fac_id ASC NULLS LAST);
