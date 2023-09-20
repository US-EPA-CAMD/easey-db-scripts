CREATE TABLE IF NOT EXISTS camdecmpsmd.es_parameter
(
    es_parameter_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_parameter
    IS 'cross-reference from category code to parameter code for error suppression.';

COMMENT ON COLUMN camdecmpsmd.es_parameter.es_parameter_group_cd
    IS ' code used to identify the error suppression parameter group to which the parameter belongs.';

COMMENT ON COLUMN camdecmpsmd.es_parameter.parameter_cd
    IS 'code used to identify the parameter. ';