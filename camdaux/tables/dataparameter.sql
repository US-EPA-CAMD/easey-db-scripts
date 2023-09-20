CREATE TABLE IF NOT EXISTS camdaux.dataparameter
(
    parameter_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    datatable_id integer NOT NULL,
    parameter_order integer NOT NULL,
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    default_value character varying(50) COLLATE pg_catalog."default"
);