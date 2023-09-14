CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_default
(
    mondef_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    default_value numeric(15,4) NOT NULL,
    default_purpose_cd character varying(7) COLLATE pg_catalog."default",
    default_source_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    group_id character varying(10) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    default_uom_cd character varying(7) COLLATE pg_catalog."default"
);
