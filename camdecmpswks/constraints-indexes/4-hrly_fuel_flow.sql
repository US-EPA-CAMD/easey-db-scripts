ALTER TABLE IF EXISTS camdecmpswks.hrly_fuel_flow
    ADD CONSTRAINT pk_hrly_fuel_flow PRIMARY KEY (hrly_fuel_flow_id),
    ADD CONSTRAINT fk_hrly_fuel_flow_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_mass_code FOREIGN KEY (sod_mass_cd)
        REFERENCES camdecmpsmd.sod_mass_code (sod_mass_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_volumetric_code FOREIGN KEY (sod_volumetric_cd)
        REFERENCES camdecmpsmd.sod_volumetric_code (sod_volumetric_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_units_of_measure_code FOREIGN KEY (volumetric_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_rpt_period_id
    ON camdecmpswks.hrly_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_mon_loc_id
    ON camdecmpswks.hrly_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_fuel_cd
    ON camdecmpswks.hrly_fuel_flow USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_hour_id
    ON camdecmpswks.hrly_fuel_flow USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_mon_sys_id
    ON camdecmpswks.hrly_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_mass_cd
    ON camdecmpswks.hrly_fuel_flow USING btree
    (sod_mass_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_volumetric_cd
    ON camdecmpswks.hrly_fuel_flow USING btree
    (sod_volumetric_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_volumetric_uom_cd
    ON camdecmpswks.hrly_fuel_flow USING btree
    (volumetric_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_rpt_period_id_mon_loc_id
    ON camdecmpswks.hrly_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
