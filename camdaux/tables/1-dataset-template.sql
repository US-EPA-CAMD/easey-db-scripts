-- Table: camdaux.dataset_template

-- DROP TABLE camdaux.dataset_template;

CREATE TABLE camdaux.dataset_template
(
    template_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    template_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_dataset_template PRIMARY KEY (template_cd)
);

--CAMPD v1.1
INSERT INTO camdaux.dataset_template(template_cd, template_cd_description)
VALUES ('MDM', 'Template code for Master Data code tables');

--ECMPS 2.0
/*
INSERT INTO camdaux.dataset_template(template_cd, template_cd_description)
VALUES
    ('EMVIEW', 'Template code for ECMPS Emissions data views'),
    ('DTLRPT', 'Template code for ECMPS Detailed reports'),
    ('SUMRPT', 'Template code for for ECMPS Summary reports');
*/