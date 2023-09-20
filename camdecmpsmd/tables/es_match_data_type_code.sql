CREATE TABLE IF NOT EXISTS camdecmpsmd.es_match_data_type_code
(
    es_match_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_match_data_type_description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    es_match_data_type_label character varying(12) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_match_data_type_code
    IS 'Lookup table for error suppression match data type.';

COMMENT ON COLUMN camdecmpsmd.es_match_data_type_code.es_match_data_type_cd
    IS ' The matching data type for the suppression.';

COMMENT ON COLUMN camdecmpsmd.es_match_data_type_code.es_match_data_type_description
    IS ' The matching data type description.';

COMMENT ON COLUMN camdecmpsmd.es_match_data_type_code.es_match_data_type_label
    IS ' The matching data type display label.';