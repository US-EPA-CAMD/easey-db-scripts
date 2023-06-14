-- Table: camdecmps.monitor_system

-- DROP TABLE camdecmps.monitor_system;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_system
(
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    system_identifier character varying(3) COLLATE pg_catalog."default" NOT NULL,
    sys_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    sys_designation_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_system PRIMARY KEY (mon_sys_id),
    CONSTRAINT fk_monitor_system_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_system_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_system_system_designation_code FOREIGN KEY (sys_designation_cd)
        REFERENCES camdecmpsmd.system_designation_code (sys_designation_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_system_system_type_code FOREIGN KEY (sys_type_cd)
        REFERENCES camdecmpsmd.system_type_code (sys_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_system
    IS 'Set of components used to measure and report the Emissions parameter identified in the monitoring method table. Record Type 510.';

COMMENT ON COLUMN camdecmps.monitor_system.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.monitor_system.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_system.system_identifier
    IS 'The three digit code used by the source to identify the monitoring system. ';

COMMENT ON COLUMN camdecmps.monitor_system.sys_type_cd
    IS 'Code used to identify the type (parameter) of the system. ';

COMMENT ON COLUMN camdecmps.monitor_system.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_system.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_system.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_system.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_system.sys_designation_cd
    IS 'Code used to indicate designation of monitoring system as primary, backup etc. ';

COMMENT ON COLUMN camdecmps.monitor_system.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.monitor_system.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_system.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_system.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_monitor_system_fuel_cd

-- DROP INDEX camdecmps.idx_monitor_system_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_monitor_system_fuel_cd
    ON camdecmps.monitor_system USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_system_mon_loc_id

-- DROP INDEX camdecmps.idx_monitor_system_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_monitor_system_mon_loc_id
    ON camdecmps.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_system_sys_design

-- DROP INDEX camdecmps.idx_monitor_system_sys_design;

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_design
    ON camdecmps.monitor_system USING btree
    (sys_designation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_system_sys_type_c

-- DROP INDEX camdecmps.idx_monitor_system_sys_type_c;

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_type_c
    ON camdecmps.monitor_system USING btree
    (sys_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_system_uq

-- DROP INDEX camdecmps.idx_monitor_system_uq;

CREATE UNIQUE INDEX idx_monitor_system_uq
    ON camdecmps.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST, system_identifier COLLATE pg_catalog."default" ASC NULLS LAST);
