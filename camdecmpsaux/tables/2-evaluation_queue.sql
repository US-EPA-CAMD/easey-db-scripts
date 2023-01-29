-- Table: camdecmpsaux.evaluation_queue

-- DROP TABLE IF EXISTS camdecmpsaux.evaluation_queue;

CREATE TABLE IF NOT EXISTS camdecmpsaux.evaluation_queue
(
    evaluation_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    evaluation_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    process_cd character varying(8) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    severity_cd character varying(8) COLLATE pg_catalog."default",
    submitted_on timestamp without time zone NOT NULL,
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_evaluation PRIMARY KEY (evaluation_id),
    CONSTRAINT fk_evaluation_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmpswks.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_evaluation_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_evaluation_set FOREIGN KEY (evaluation_set_id)
        REFERENCES camdecmpsaux.evaluation_set (evaluation_set_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_evaluation_test_extension_exemption FOREIGN KEY (test_extension_exemption_id)
        REFERENCES camdecmpswks.test_extension_exemption (test_extension_exemption_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_evaluation_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue
    OWNER to "uImcwuf4K9dyaxeL";