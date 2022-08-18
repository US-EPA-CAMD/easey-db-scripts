-- Table: camdecmpsaux.report

-- DROP TABLE camdecmpsaux.report;

CREATE TABLE camdecmpsaux.report
(
    report_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    report_type_cd text COLLATE pg_catalog."default" NOT NULL,
    report_title text COLLATE pg_catalog."default" NOT NULL,
    no_results_msg text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_report PRIMARY KEY (report_id)
);