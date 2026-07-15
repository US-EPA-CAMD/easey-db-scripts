CREATE TABLE IF NOT EXISTS camdmd.email_criteria
(
    email_criteria varchar(50) NOT NULL,
    lookup_table_name varchar(50) NOT NULL,
    lookup_code_field_name varchar(50) NOT NULL,
    lookup_value_field_name varchar(50) NOT NULL,
    email_criteria_cd varchar(20),
    lookup_filter varchar(1000)
);
COMMENT ON TABLE camdmd.email_criteria
    IS 'Stores the email criteria for CSA email generator.';
COMMENT ON COLUMN camdmd.email_criteria.email_criteria
    IS 'Description of Email Criteria.';
COMMENT ON COLUMN camdmd.email_criteria.lookup_table_name
    IS 'Lookup table used for display.';
COMMENT ON COLUMN camdmd.email_criteria.lookup_code_field_name
    IS 'Lookup field used for code.';
COMMENT ON COLUMN camdmd.email_criteria.lookup_value_field_name
    IS 'Lookup field used for value.';
COMMENT ON COLUMN camdmd.email_criteria.email_criteria_cd
    IS 'Lookup code for email criteria.';
COMMENT ON COLUMN camdmd.email_criteria.lookup_filter
    IS 'Filter to be applied to email criteria (e.g., do not return OTC records).';