-- Table: camdecmpsmd.es_parameter_category

-- DROP TABLE camdecmpsmd.es_parameter_category;

CREATE TABLE IF EXISTS camdecmpsmd.es_parameter_category
(
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_parameter_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_es_parameter_category PRIMARY KEY (category_cd, es_parameter_group_cd),
    CONSTRAINT fk_es_parameter_category_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_es_parameter_category_es_parameter_group_code FOREIGN KEY (es_parameter_group_cd)
        REFERENCES camdecmpsmd.es_parameter_group_code (es_parameter_group_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.es_parameter_category
    IS 'cross-reference from category code to parameter code for error suppression.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_category.category_cd
    IS 'code used to identify the check category.';

COMMENT ON COLUMN camdecmpsmd.es_parameter_category.es_parameter_group_cd
    IS 'code used to identify the error suppression parameter group. ';