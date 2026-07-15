CREATE TABLE IF NOT EXISTS camdmd.email_criteria_selection
(
    email_category_cd varchar(20) NOT NULL,
    email_criteria_cd varchar(20) NOT NULL,
    display_order numeric(38,0) NOT NULL,
    email_criteria_selection_id numeric(38,0) NOT NULL,
    PRIMARY KEY (email_criteria_selection_id)
);
COMMENT ON TABLE camdmd.email_criteria_selection
    IS 'Links email generator recipient category codes with specific criteria.';
COMMENT ON COLUMN camdmd.email_criteria_selection.email_category_cd
    IS 'Lookup code for email category.';
COMMENT ON COLUMN camdmd.email_criteria_selection.email_criteria_cd
    IS 'Lookup code for email criteria.';
COMMENT ON COLUMN camdmd.email_criteria_selection.display_order
    IS 'Stores display order for criteria for email generator recipient selection.';
COMMENT ON COLUMN camdmd.email_criteria_selection.email_criteria_selection_id
    IS 'Unique Identifier for Email Criteria Selection';