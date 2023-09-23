CREATE TABLE IF NOT EXISTS camdecmpswks.linearity_injection
(
    lin_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    lin_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    injection_date date NOT NULL,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);