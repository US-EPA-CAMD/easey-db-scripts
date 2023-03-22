-- Table: camdaux.datatable

-- DROP TABLE camdaux.datatable;

CREATE TABLE IF NOT EXISTS camdaux.datatable
(
    datatable_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    dataset_cd character varying(50) COLLATE pg_catalog."default" NOT NULL,
    table_order integer NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sql_statement character varying(1000) COLLATE pg_catalog."default",
    no_results_msg_override character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_datatable PRIMARY KEY (datatable_id),
    CONSTRAINT uq_datatable UNIQUE (dataset_cd, table_order),
    CONSTRAINT fk_datatable_dataset FOREIGN KEY (dataset_cd)
        REFERENCES camdaux.dataset (dataset_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);