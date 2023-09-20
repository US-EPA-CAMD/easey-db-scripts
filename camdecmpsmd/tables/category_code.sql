CREATE TABLE IF NOT EXISTS camdecmpsmd.category_code
(
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    process_cd character varying(7) COLLATE pg_catalog."default",
    category_cd_description character varying(1000) COLLATE pg_catalog."default",
    display_order numeric(38,0),
    record_type numeric(38,0),
    category_cd_notes text COLLATE pg_catalog."default",
    es_match_loc_type_cd character varying(7) COLLATE pg_catalog."default",
    es_match_data_type_cd character varying(7) COLLATE pg_catalog."default",
    es_match_time_type_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.category_code
    IS 'Categories of evaluation check types.';

COMMENT ON COLUMN camdecmpsmd.category_code.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpsmd.category_code.process_cd
    IS ' Code used to identify the check process.';

COMMENT ON COLUMN camdecmpsmd.category_code.category_cd_description
    IS ' Description of lookup code.';

COMMENT ON COLUMN camdecmpsmd.category_code.display_order
    IS ' Used to order the check categories.';

COMMENT ON COLUMN camdecmpsmd.category_code.record_type
    IS ' The equivalent EDR record type.';

COMMENT ON COLUMN camdecmpsmd.category_code.category_cd_notes
    IS 'Notes indicating coding specifications and considerations for the category.';

COMMENT ON COLUMN camdecmpsmd.category_code.es_match_loc_type_cd
    IS 'The matching location type for the suppression.';

COMMENT ON COLUMN camdecmpsmd.category_code.es_match_data_type_cd
    IS 'The matching data type for the suppression.';

COMMENT ON COLUMN camdecmpsmd.category_code.es_match_time_type_cd
    IS 'The matching time type for the suppression.';
