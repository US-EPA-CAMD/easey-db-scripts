CREATE TABLE IF NOT EXISTS camdmd.attachment
(
    attachment_id numeric(38,0) NOT NULL,
    attachment_description varchar(120) NOT NULL,
    attachment_name varchar(120) NOT NULL,
    content_type varchar(120) NOT NULL,
    attachment_clob clob,
    attachment_blob blob,
    PRIMARY KEY (attachment_id)
);
COMMENT ON TABLE camdmd.attachment
    IS 'Lookup table containing static email attachment content.';
COMMENT ON COLUMN camdmd.attachment.attachment_id
    IS 'ATTACHMENT identity key.';
COMMENT ON COLUMN camdmd.attachment.attachment_description
    IS 'The description of the attachment.';
COMMENT ON COLUMN camdmd.attachment.attachment_name
    IS 'The name of the attachment.';
COMMENT ON COLUMN camdmd.attachment.content_type
    IS 'The content type of the attachment, i.e. application/pdf or image/jpg, text/html, etc.';
COMMENT ON COLUMN camdmd.attachment.attachment_clob
    IS 'CLOB representation of the attachment.';
COMMENT ON COLUMN camdmd.attachment.attachment_blob
    IS 'BLOB representation of the attachment.';