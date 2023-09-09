CREATE TABLE IF NOT EXISTS camdecmpsaux.evaluation_set
(
    evaluation_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    submitted_on timestamp without time zone NOT NULL,
    user_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    fac_name character varying(200) COLLATE pg_catalog."default" NOT NULL,
    configuration character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_evaluation_set PRIMARY KEY (evaluation_set_id),
    CONSTRAINT fk_evaluation_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
);
