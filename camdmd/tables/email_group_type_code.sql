CREATE TABLE IF NOT EXISTS camdmd.email_group_type_code
(
    email_group_type_cd varchar(7) NOT NULL,
    email_group_type_description varchar(100) NOT NULL,
    PRIMARY KEY (email_group_type_cd)
);
COMMENT ON TABLE camdmd.email_group_type_code
    IS 'Lookup table containing EMAIL_GROUP_TYPE_CODE definitions used for emails.';
COMMENT ON COLUMN camdmd.email_group_type_code.email_group_type_cd
    IS 'EMAIL_GROUP_TYPE_CODE identity key.';
COMMENT ON COLUMN camdmd.email_group_type_code.email_group_type_description
    IS 'The description of the EMAIL_GROUP_TYPE_CD.';