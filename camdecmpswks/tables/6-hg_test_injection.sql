-- Table: camdecmpswks.hg_test_injection

-- DROP TABLE camdecmpswks.hg_test_injection;

CREATE TABLE camdecmpswks.hg_test_injection
(
    hg_test_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hg_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    injection_date date NOT NULL,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_hg_test_injection PRIMARY KEY (hg_test_inj_id),
    CONSTRAINT fk_hg_test_injection_hg_test_summary FOREIGN KEY (hg_test_sum_id)
        REFERENCES camdecmpswks.hg_test_summary (hg_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);