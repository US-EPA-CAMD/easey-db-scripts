-- Table: camdecmpsmd.es_match_loc_type_code

-- DROP TABLE camdecmpsmd.es_match_loc_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.es_match_loc_type_code
(
    es_match_loc_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_match_loc_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT es_match_loc_type_code_pk PRIMARY KEY (es_match_loc_type_cd),
    CONSTRAINT es_match_loc_type_code_uq UNIQUE (es_match_loc_type_description)
);

COMMENT ON TABLE camdecmpsmd.es_match_loc_type_code
    IS 'Lookup table for error suppression match location type.';

COMMENT ON COLUMN camdecmpsmd.es_match_loc_type_code.es_match_loc_type_cd
    IS ' The matching location type for the suppression.';

COMMENT ON COLUMN camdecmpsmd.es_match_loc_type_code.es_match_loc_type_description
    IS ' The matching location type description.';