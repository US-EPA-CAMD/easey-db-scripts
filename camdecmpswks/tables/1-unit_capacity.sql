-- Table: camdecmpswks.unit_capacity

-- DROP TABLE camdecmpswks.unit_capacity;

CREATE TABLE IF NOT EXISTS camdecmpswks.unit_capacity
(
    unit_cap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    begin_date date,
    end_date date,
    max_hi_capacity numeric(7,1),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_capacity PRIMARY KEY (unit_cap_id),
    CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);