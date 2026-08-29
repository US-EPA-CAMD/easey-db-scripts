CREATE TABLE IF NOT EXISTS camdmd.email_criteria_category
(
    email_category_cd varchar(20) NOT NULL,
    email_category varchar(50) NOT NULL,
    category_order numeric(38,0) NOT NULL,
    selection_query varchar(4000),
    PRIMARY KEY (email_category_cd)
);
COMMENT ON TABLE camdmd.email_criteria_category
    IS 'Stores categories of email generator recipients.';
COMMENT ON COLUMN camdmd.email_criteria_category.email_category_cd
    IS 'Lookup code for email category.';
COMMENT ON COLUMN camdmd.email_criteria_category.email_category
    IS 'Type of email generator recipient (e.g., representative).';
COMMENT ON COLUMN camdmd.email_criteria_category.category_order
    IS 'Order for email generator recipients.';
COMMENT ON COLUMN camdmd.email_criteria_category.selection_query
    IS 'Query to select for the category.';