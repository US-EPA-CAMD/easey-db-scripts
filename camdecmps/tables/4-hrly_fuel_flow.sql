-- Table: camdecmps.hrly_fuel_flow

-- DROP TABLE IF EXISTS camdecmps.hrly_fuel_flow;

CREATE TABLE IF NOT EXISTS camdecmps.hrly_fuel_flow
(
    hrly_fuel_flow_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_usage_time numeric(3,2),
    volumetric_flow_rate numeric(10,1),
    sod_volumetric_cd character varying(7) COLLATE pg_catalog."default",
    mass_flow_rate numeric(10,1),
    calc_mass_flow_rate numeric(10,1),
    sod_mass_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    volumetric_uom_cd character varying(7) COLLATE pg_catalog."default",
    calc_volumetric_flow_rate numeric(10,1),
    calc_appd_status character varying(75) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_hrly_fuel_flow PRIMARY KEY (hrly_fuel_flow_id),
    CONSTRAINT fk_fuel_code_hrly_fuel_flo FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_syste_hrly_fuel_flo FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sod_mass_code_hrly_fuel_flo FOREIGN KEY (sod_mass_cd)
        REFERENCES camdecmpsmd.sod_mass_code (sod_mass_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sod_volumetri_hrly_fuel_flo FOREIGN KEY (sod_volumetric_cd)
        REFERENCES camdecmpsmd.sod_volumetric_code (sod_volumetric_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_hrly_fuel_flo FOREIGN KEY (volumetric_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hrly_fuel_flow_r01 FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.hrly_fuel_flow
    IS 'Hourly fuel flow data for Appendix D.  Record Type 302 and 303.';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.hrly_fuel_flow_id
    IS 'Unique identifier of an hourly fuel flow record. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.fuel_usage_time
    IS 'Fuel usage time. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.volumetric_flow_rate
    IS 'Volumetric flow rate during combustion. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.sod_volumetric_cd
    IS 'Code used to identify the source of volumetric flow rate. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.mass_flow_rate
    IS 'Mass flow rate during combustion. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.calc_mass_flow_rate
    IS 'Mass flow rate during combustion. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.sod_mass_cd
    IS 'Code used to identify the source of mass flow rate. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.volumetric_uom_cd
    IS 'Code used to identify the units of measure for volumetric fuel flow. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.calc_volumetric_flow_rate
    IS 'Volumetric flow rate during combustion. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.calc_appd_status
    IS 'QA Status for Appendix D Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.hrly_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
-- Index: hrly_fuel_flow_idx001

-- DROP INDEX IF EXISTS camdecmps.hrly_fuel_flow_idx001;

CREATE INDEX IF NOT EXISTS hrly_fuel_flow_idx001
    ON camdecmps.hrly_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hff_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_hff_add_date;

CREATE INDEX IF NOT EXISTS idx_hff_add_date
    ON camdecmps.hrly_fuel_flow USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_fuel_cd

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_fuel_cd
    ON camdecmps.hrly_fuel_flow USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_hour_id

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_hour_id;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_hour_id
    ON camdecmps.hrly_fuel_flow USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_mon_sys_id

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_mon_sys_id
    ON camdecmps.hrly_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_sod_mass_c

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_mass_c;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_mass_c
    ON camdecmps.hrly_fuel_flow USING btree
    (sod_mass_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_sod_volume

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_volume;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_volume
    ON camdecmps.hrly_fuel_flow USING btree
    (sod_volumetric_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_fuel_flow_volumetric

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_volumetric;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_volumetric
    ON camdecmps.hrly_fuel_flow USING btree
    (volumetric_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;