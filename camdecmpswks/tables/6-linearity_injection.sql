-- Table: camdecmpswks.linearity_injection

-- DROP TABLE camdecmpswks.linearity_injection;

CREATE TABLE camdecmpswks.linearity_injection
(
    lin_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    lin_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    injection_date date NOT NULL,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_linearity_injection PRIMARY KEY (lin_inj_id),
    CONSTRAINT fk_linearity_injection_linearity_summary FOREIGN KEY (lin_sum_id)
        REFERENCES camdecmpswks.linearity_summary (lin_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);