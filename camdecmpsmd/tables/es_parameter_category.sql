CREATE TABLE IF NOT EXISTS camdecmpsmd.es_parameter_category
(
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_parameter_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_parameter_category
    IS 'cross-reference from category code to parameter code for error suppression.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_category.category_cd
    IS 'code used to identify the check category.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_category.es_parameter_group_cd
    IS 'code used to identify the error suppression parameter group. ';