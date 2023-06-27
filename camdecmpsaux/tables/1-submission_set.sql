-- Table: camdecmpsaux.submission_set

-- DROP TABLE camdecmpsaux.submission_set;

CREATE TABLE IF NOT EXISTS camdecmpsaux.submission_set
(
    submission_set_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    activity_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    user_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    CONSTRAINT pk_submission_set PRIMARY KEY (submission_set_id),
    CONSTRAINT fk_submission_set_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);