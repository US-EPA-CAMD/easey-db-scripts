-- Table: camdecmpsaux.submission_set

-- DROP TABLE camdecmpsaux.submission_set;
CREATE TABLE IF NOT EXISTS camdecmpsaux.submission_set
(
    submission_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    submitted_on timestamp without time zone NOT NULL,
    user_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    fac_name character varying(200) COLLATE pg_catalog."default" NOT NULL,
    activity_id text COLLATE pg_catalog."default" NOT NULL,
    configuration character varying(100) COLLATE pg_catalog."default" NOT NULL,
    status_cd character varying(8) COLLATE pg_catalog."default",
    details text COLLATE pg_catalog."default",
    CONSTRAINT pk_submission_set PRIMARY KEY (submission_set_id),
    CONSTRAINT fk_submission_set_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)