CREATE TABLE IF NOT EXISTS camdecmpswks.unit_control
(
    ctl_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    control_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ce_param character varying(7) COLLATE pg_catalog."default" NOT NULL,
    install_date date,
    opt_date date,
    orig_cd character varying(1) COLLATE pg_catalog."default",
    seas_cd character varying(1) COLLATE pg_catalog."default",
    retire_date date,
    indicator_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);
