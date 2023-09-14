CREATE TABLE IF NOT EXISTS camdecmpsmd.es_match_time_type_code
(
    es_match_time_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_match_time_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_match_time_type_code
    IS 'Lookup table for error suppression match time type.';

COMMENT ON COLUMN camdecmpsmd.es_match_time_type_code.es_match_time_type_cd
    IS ' The matching time type for the suppression.';

COMMENT ON COLUMN camdecmpsmd.es_match_time_type_code.es_match_time_type_description
    IS ' The matching time type description.';