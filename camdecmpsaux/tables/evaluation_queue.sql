CREATE TABLE IF NOT EXISTS camdecmpsaux.evaluation_queue
(
    evaluation_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    evaluation_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    process_cd character varying(8) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    eval_status_cd character varying(8) COLLATE pg_catalog."default",
    submitted_on timestamp without time zone NOT NULL,
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    details text COLLATE pg_catalog."default"
);