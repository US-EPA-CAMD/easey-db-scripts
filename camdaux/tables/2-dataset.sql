-- Table: camdaux.dataset

-- DROP TABLE camdaux.dataset;

CREATE TABLE IF NOT EXISTS camdaux.dataset
(
    dataset_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    template_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    no_results_msg character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_dataset PRIMARY KEY (dataset_cd),
    CONSTRAINT fk_dataset_template FOREIGN KEY (template_cd)
        REFERENCES camdaux.dataset_template (template_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);
