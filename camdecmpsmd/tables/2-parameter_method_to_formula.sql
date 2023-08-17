-- Table: camdecmpsmd.parameter_method_to_formula

-- DROP TABLE camdecmpsmd.parameter_method_to_formula;

CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_method_to_formula
(
    param_method_to_formula_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    system_type_list character varying(1000) COLLATE pg_catalog."default",
    ecmps_only character varying(3) COLLATE pg_catalog."default",
    location_type_list character varying(1000) COLLATE pg_catalog."default",
    formula_list character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    not_found_result character varying(75) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_parameter_method_to_formula PRIMARY KEY (param_method_to_formula_id),
    CONSTRAINT uq_parameter_method_to_formula UNIQUE (parameter_cd, method_cd, system_type_list, location_type_list),
    CONSTRAINT fk_parameter_method_to_formula_method_code FOREIGN KEY (method_cd)
        REFERENCES camdecmpsmd.method_code (method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_parameter_method_to_formula_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);