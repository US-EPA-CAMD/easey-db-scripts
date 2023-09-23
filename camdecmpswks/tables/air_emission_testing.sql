CREATE TABLE IF NOT EXISTS camdecmpswks.air_emission_testing
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
    userid character varying(160) COLLATE pg_catalog."default"
);