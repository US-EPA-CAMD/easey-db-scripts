CREATE TABLE IF NOT EXISTS camdaux.datacolumn
(
    datacolumn_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    datatable_id integer NOT NULL,
    column_order integer NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    alias character varying(50) COLLATE pg_catalog."default",
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL
);