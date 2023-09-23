CREATE TABLE IF NOT EXISTS camdecmpswks.stack_pipe
(
    stack_pipe_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    stack_name character varying(6) COLLATE pg_catalog."default" NOT NULL,
    active_date date NOT NULL,
    retire_date date,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);