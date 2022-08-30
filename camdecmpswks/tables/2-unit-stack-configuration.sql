-- Table: camdecmpswks.unit_stack_configuration

-- DROP TABLE camdecmpswks.unit_stack_configuration;

CREATE TABLE camdecmpswks.unit_stack_configuration
(
    config_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    stack_pipe_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_stack_configuration PRIMARY KEY (config_id),
    CONSTRAINT fk_unit_stack_configuration_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmpswks.stack_pipe (stack_pipe_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);