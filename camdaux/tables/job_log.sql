CREATE TABLE IF NOT EXISTS camdaux.job_log
(
    job_id uuid NOT NULL,
    job_system character varying COLLATE pg_catalog."default" NOT NULL,
    job_class character varying COLLATE pg_catalog."default" NOT NULL,
    job_name character varying COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    status_cd character varying(8) COLLATE pg_catalog."default" DEFAULT 'QUEUED'::character varying,
    additional_details character varying COLLATE pg_catalog."default"
);
