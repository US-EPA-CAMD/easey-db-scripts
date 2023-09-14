CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_parameter
(
    check_catalog_param_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    check_catalog_id integer NOT NULL,
    check_param_id integer NOT NULL,
    check_param_usage_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);