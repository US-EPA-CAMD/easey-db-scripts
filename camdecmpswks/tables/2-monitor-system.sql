-- Table: camdecmpswks.monitor_system

-- DROP TABLE camdecmpswks.monitor_system;

CREATE TABLE camdecmpswks.monitor_system
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
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
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