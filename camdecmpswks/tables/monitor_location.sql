CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_location
(
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    stack_pipe_id character varying(45) COLLATE pg_catalog."default",
    unit_id numeric(38,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);