-- Table: camdaux.dataset_template

-- DROP TABLE camdaux.dataset_template;

CREATE TABLE IF NOT EXISTS camdaux.dataset_template
(
    template_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    template_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_dataset_template PRIMARY KEY (template_cd)
);
