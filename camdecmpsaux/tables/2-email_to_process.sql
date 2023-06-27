-- Table: camdecmpsaux.email_to_process

-- DROP TABLE camdecmpsaux.email_to_process;

CREATE TABLE IF NOT EXISTS camdecmpsaux.email_to_process
(
    to_process_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    fac_id numeric(38,0) NOT NULL,
    email_type character varying(100) COLLATE pg_catalog."default" NOT NULL,
    event_code integer,
    userid character varying(25) COLLATE pg_catalog."default",
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric,
    em_sub_access_id bigint,
    submission_type character varying(3) COLLATE pg_catalog."default",
    is_mats boolean,
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_email_to_process PRIMARY KEY (to_process_id),
    CONSTRAINT fk_email_to_process_em_sub_access FOREIGN KEY (em_sub_access_id)
        REFERENCES camdecmpsaux.em_submission_access (em_sub_access_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_email_to_process_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_email_to_process_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_email_to_process_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);