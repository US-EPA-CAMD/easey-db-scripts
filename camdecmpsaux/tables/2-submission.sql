-- Table: camdecmpsaux.submission

-- DROP TABLE camdecmpsaux.submission;

CREATE TABLE IF NOT EXISTS camdecmpsaux.submission
(
    submission_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    submission_set_id bigint NOT NULL,
    submission_type_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    submission_status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0),
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    severity_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    user_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_submission PRIMARY KEY (submission_id),
    CONSTRAINT fk_submission_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmps.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_submission_set FOREIGN KEY (submission_set_id)
        REFERENCES camdecmpsaux.submission_set (submission_set_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_submission_test_extension_exemption FOREIGN KEY (test_extension_exemption_id)
        REFERENCES camdecmps.test_extension_exemption (test_extension_exemption_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT chk_submission_status_code CHECK (submission_status_cd::text = ANY (ARRAY['QUEUED'::character varying::text, 'WIP'::character varying::text, 'LOADED'::character varying::text, 'RECCRIT'::character varying::text, 'ERROR'::character varying::text])),
    CONSTRAINT chk_submission_type_code CHECK (submission_type_cd::text = ANY (ARRAY['MP'::character varying::text, 'QA'::character varying::text, 'EM'::character varying::text]))
);