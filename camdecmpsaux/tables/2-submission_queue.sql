CREATE TABLE IF NOT EXISTS camdecmpsaux.submission_queue
(
    submission_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    submission_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    process_cd character varying(8) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
	mats_bulk_file_id bigint,
    severity_cd character varying(8) COLLATE pg_catalog."default",
    submitted_on timestamp without time zone NOT NULL,
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    details text COLLATE pg_catalog."default",
    CONSTRAINT pk_submission_queue PRIMARY KEY (submission_id),
    CONSTRAINT fk_evaluation_queue_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmpswks.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_evaluation_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_evaluation_queue_test_extension_exemption FOREIGN KEY (test_extension_exemption_id)
        REFERENCES camdecmpswks.test_extension_exemption (test_extension_exemption_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_evaluation_queue_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_submission_queue_submission_set FOREIGN KEY (submission_set_id)
        REFERENCES camdecmpsaux.submission_set (submission_set_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)