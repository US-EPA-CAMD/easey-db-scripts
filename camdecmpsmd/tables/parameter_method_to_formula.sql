CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_method_to_formula
(
    param_method_to_formula_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    system_type_list character varying(1000) COLLATE pg_catalog."default",
    ecmps_only character varying(3) COLLATE pg_catalog."default",
    location_type_list character varying(1000) COLLATE pg_catalog."default",
    formula_list character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    not_found_result character varying(75) COLLATE pg_catalog."default" NOT NULL
);