CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_plugin
(
    check_catalog_plugin_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    plugin_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    check_catalog_id integer NOT NULL,
    plugin_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_param_id integer,
    field_name character varying(100) COLLATE pg_catalog."default"
);
