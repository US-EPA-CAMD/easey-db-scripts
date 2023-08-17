-- Table: camdecmpsmd.check_catalog_parameter

-- DROP TABLE camdecmpsmd.check_catalog_parameter;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_parameter
(
    check_catalog_param_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    check_catalog_id integer NOT NULL,
    check_param_id integer NOT NULL,
    check_param_usage_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_check_catalog_parameter PRIMARY KEY (check_catalog_param_id),
    CONSTRAINT fk_check_catalog_parameter_check_catalog FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_check_catalog_parameter_check_parameter_code FOREIGN KEY (check_param_id)
        REFERENCES camdecmpsmd.check_parameter_code (check_param_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_check_catalog_parameter_check_parameter_usage_code FOREIGN KEY (check_param_usage_cd)
        REFERENCES camdecmpsmd.check_parameter_usage_code (check_param_usage_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);