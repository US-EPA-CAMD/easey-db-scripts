-- Table: camdaux.dataset

-- DROP TABLE IF EXISTS camdaux.dataset;

CREATE TABLE IF NOT EXISTS camdaux.dataset
(
    dataset_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sort_order integer,
    no_results_msg character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_dataset PRIMARY KEY (dataset_cd),
    CONSTRAINT ck_group_cd CHECK (group_cd::text = ANY (ARRAY['MDM'::text, 'MDMREL'::text, 'REPORT'::text, 'EMVIEW'::text]))
);
