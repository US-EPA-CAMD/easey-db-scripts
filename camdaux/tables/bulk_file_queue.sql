CREATE TABLE IF NOT EXISTS camdaux.bulk_file_queue
(
    job_id uuid NOT NULL,
    parent_job_id uuid,
    job_name character varying COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    status_cd character varying(8) COLLATE pg_catalog."default" DEFAULT 'QUEUED'::character varying,
    year integer,
    quarter integer,
    state_cd character varying(3) COLLATE pg_catalog."default",
    data_type character varying(50) COLLATE pg_catalog."default",
    sub_type character varying(50) COLLATE pg_catalog."default",
    url character varying(300) COLLATE pg_catalog."default",
    file_name character varying(200) COLLATE pg_catalog."default",
    program_cd character varying(12) COLLATE pg_catalog."default",
    additional_details character varying COLLATE pg_catalog."default"
)