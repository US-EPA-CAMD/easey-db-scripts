CREATE TABLE IF NOT EXISTS camdecmpsmd.cross_check_catalog
(
    cross_chk_catalog_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 98 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    cross_chk_catalog_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    cross_chk_catalog_description character varying(1000) COLLATE pg_catalog."default",
    table_name1 character varying(100) COLLATE pg_catalog."default",
    column_name1 character varying(100) COLLATE pg_catalog."default",
    description1 character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    field_type_cd1 character varying(7) COLLATE pg_catalog."default",
    table_name2 character varying(100) COLLATE pg_catalog."default",
    column_name2 character varying(100) COLLATE pg_catalog."default",
    description2 character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    field_type_cd2 character varying(7) COLLATE pg_catalog."default",
    table_name3 character varying(100) COLLATE pg_catalog."default",
    column_name3 character varying(100) COLLATE pg_catalog."default",
    description3 character varying(1000) COLLATE pg_catalog."default",
    field_type_cd3 character varying(7) COLLATE pg_catalog."default"
);
