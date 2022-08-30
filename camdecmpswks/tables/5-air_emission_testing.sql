-- Table: camdecmpswks.air_emission_testing

-- DROP TABLE camdecmpswks.air_emission_testing;

CREATE TABLE camdecmpswks.air_emission_testing
(
    air_emission_test_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qi_last_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    qi_first_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    qi_middle_initial character varying(1) COLLATE pg_catalog."default",
    aetb_name character varying(50) COLLATE pg_catalog."default",
    aetb_phone_number character varying(18) COLLATE pg_catalog."default",
    aetb_email character varying(70) COLLATE pg_catalog."default",
    exam_date date,
    provider_name character varying(50) COLLATE pg_catalog."default",
    provider_email character varying(70) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT pk_air_emission_testing PRIMARY KEY (air_emission_test_id),
    CONSTRAINT fk_air_emission_testing_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);