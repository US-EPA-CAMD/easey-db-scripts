CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_code
(
    check_param_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    check_param_id_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    check_param_id_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    source_table character varying(100) COLLATE pg_catalog."default",
    check_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    chk_param_type_cd character varying(7) COLLATE pg_catalog."default",
    object_type character varying(100) COLLATE pg_catalog."default"
);
