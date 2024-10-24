CREATE TABLE IF NOT EXISTS camdecmpsmd.es_parameter_group_code
(
    es_parameter_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_parameter_group_description character varying(100) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_parameter_group_code
    IS 'lookup table for error suppression parameter groups.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_group_code.es_parameter_group_cd
    IS ' code used to identify the error suppression parameter group.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_group_code.es_parameter_group_description
    IS 'the error suppression parameter group description. ';