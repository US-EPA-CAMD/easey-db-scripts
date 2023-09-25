CREATE TABLE IF NOT EXISTS camdecmpsaux.submission_set
(
    submission_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    submitted_on timestamp without time zone NOT NULL,
    user_id character varying(160) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    oris_code numeric(6,0) NOT NULL,
    fac_name character varying(200) COLLATE pg_catalog."default" NOT NULL,
    activity_id text COLLATE pg_catalog."default" NOT NULL,
    configuration character varying(100) COLLATE pg_catalog."default" NOT NULL,
    status_cd character varying(8) COLLATE pg_catalog."default",
    details text COLLATE pg_catalog."default",
    submission_end_stage_time timestamp without time zone,
)
