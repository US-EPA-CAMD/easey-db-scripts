-- Table: camdecmpsaux.report_detail

-- DROP TABLE camdecmpsaux.report_detail;

CREATE TABLE camdecmpsaux.report_detail
(
    report_detail_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    report_cd character varying(25) NOT NULL,
    sequence_number integer NOT NULL,
    detail_title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sql_statement text COLLATE pg_catalog."default" NOT NULL,
    no_results_msg_override character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_report_detail PRIMARY KEY (report_detail_id),
    CONSTRAINT uq_report_detail UNIQUE (report_cd, sequence_number),
    CONSTRAINT fk_report_detail_report FOREIGN KEY (report_cd)
        REFERENCES camdecmpsaux.report (report_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);