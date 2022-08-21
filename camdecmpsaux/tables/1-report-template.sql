-- Table: camdecmpsaux.report_template

-- DROP TABLE camdecmpsaux.report_template;

CREATE TABLE camdecmpsaux.report_template
(
    report_template_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    report_template_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_report_template PRIMARY KEY (report_template_cd)
);

INSERT INTO camdecmpsaux.report_template(report_template_cd, report_template_description)
VALUES('DETAIL', 'Report template that generates a detailed report of specific records');

INSERT INTO camdecmpsaux.report_template(report_template_cd, report_template_description)
VALUES('SUMMARY', 'Report template that generates a summary report of records in a tabular format');