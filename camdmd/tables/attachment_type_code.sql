CREATE TABLE IF NOT EXISTS camdmd.attachment_type_code
(
    attachment_type_cd varchar(7) NOT NULL,
    attachment_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (attachment_type_cd)
);
COMMENT ON TABLE camdmd.attachment_type_code
    IS 'Lookup table containing codes that indicates the attachment type for emails.';
COMMENT ON COLUMN camdmd.attachment_type_code.attachment_type_cd
    IS 'The code that indicates the attachment type for emails.';
COMMENT ON COLUMN camdmd.attachment_type_code.attachment_type_description
    IS 'The description of the attachment type.';