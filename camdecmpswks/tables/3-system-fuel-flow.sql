-- Table: camdecmpswks.system_fuel_flow

-- DROP TABLE camdecmpswks.system_fuel_flow;

CREATE TABLE camdecmpswks.system_fuel_flow
(
    sys_fuel_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    max_rate numeric(9,1) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    max_rate_source_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    sys_fuel_uom_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_system_fuel_flow PRIMARY KEY (sys_fuel_id),
    CONSTRAINT fk_system_fuel_flow_max_rate_source_code FOREIGN KEY (max_rate_source_cd)
        REFERENCES camdecmpsmd.max_rate_source_code (max_rate_source_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_system_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_system_fuel_flow_units_of_measure_code FOREIGN KEY (sys_fuel_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);