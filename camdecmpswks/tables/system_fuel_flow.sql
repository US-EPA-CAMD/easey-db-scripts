CREATE TABLE IF NOT EXISTS camdecmpswks.system_fuel_flow
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
    sys_fuel_uom_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);
