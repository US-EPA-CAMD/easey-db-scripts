-- Table: camdecmpswks.stack_pipe

-- DROP TABLE camdecmpswks.stack_pipe;

CREATE TABLE IF NOT EXISTS camdecmpswks.stack_pipe
(
    stack_pipe_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    stack_name character varying(6) COLLATE pg_catalog."default" NOT NULL,
    active_date date NOT NULL,
    retire_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_stack_pipe PRIMARY KEY (stack_pipe_id),
    CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);