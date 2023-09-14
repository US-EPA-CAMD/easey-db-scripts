CREATE TABLE IF NOT EXISTS camdaux.dataset
(
    dataset_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sort_order integer,
    no_results_msg character varying(1000) COLLATE pg_catalog."default"
);
