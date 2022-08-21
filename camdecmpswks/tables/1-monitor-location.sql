-- Table: camdecmpswks.monitor_location

-- DROP TABLE camdecmpswks.monitor_location;

CREATE TABLE camdecmpswks.monitor_location
(
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    stack_pipe_id character varying(45) COLLATE pg_catalog."default",
    unit_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_location PRIMARY KEY (mon_loc_id),
    CONSTRAINT fk_monitor_location_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmpswks.stack_pipe (stack_pipe_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);