CREATE TABLE IF NOT EXISTS camdecmpsaux.email_to_process
(
    to_process_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    fac_id numeric(38,0) NOT NULL,
    email_type character varying(100) COLLATE pg_catalog."default" NOT NULL,
    event_code integer,
    userid character varying(160) COLLATE pg_catalog."default",
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric,
    em_sub_access_id bigint,
    submission_type character varying(3) COLLATE pg_catalog."default",
    is_mats boolean,
    context text COLLATE pg_catalog."default",
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL
);
