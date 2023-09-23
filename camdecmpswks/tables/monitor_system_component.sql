CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_system_component
(
    mon_sys_comp_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
