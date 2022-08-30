-- Table: camdecmpsaux.report

-- DROP TABLE camdecmpsaux.report;

CREATE TABLE camdecmpsaux.report
(
    report_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    report_title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    report_template_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    no_results_msg character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_report PRIMARY KEY (report_cd),
    CONSTRAINT fk_report_report_template FOREIGN KEY (report_template_cd)
        REFERENCES camdecmpsaux.report_template (report_template_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);