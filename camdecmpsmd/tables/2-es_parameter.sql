-- Table: camdecmpsmd.es_parameter

-- DROP TABLE camdecmpsmd.es_parameter;

CREATE TABLE IF EXISTS camdecmpsmd.es_parameter
(
    es_parameter_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_es_parameter PRIMARY KEY (es_parameter_group_cd, parameter_cd),
    CONSTRAINT fk_es_parameter_es_parameter_group_code FOREIGN KEY (es_parameter_group_cd)
        REFERENCES camdecmpsmd.es_parameter_group_code (es_parameter_group_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_es_parameter_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.es_parameter
    IS 'cross-reference from category code to parameter code for error suppression.';

COMMENT ON COLUMN camdecmpsmd.es_parameter.es_parameter_group_cd
    IS ' code used to identify the error suppression parameter group to which the parameter belongs.';

COMMENT ON COLUMN camdecmpsmd.es_parameter.parameter_cd
    IS 'code used to identify the parameter. ';