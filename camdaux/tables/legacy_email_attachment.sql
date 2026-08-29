CREATE TABLE IF NOT EXISTS camdaux.legacy_email_attachment
(
    legacy_event_id numeric,
    attachment_name varchar(200),
    attachment_clob clob,
    attachment_blob blob
);
COMMENT ON TABLE camdaux.legacy_email_attachment
    IS 'Temporary table containng legacy EVENT_ATTACHMENT_A CLOB and BLOB values.';
COMMENT ON COLUMN camdaux.legacy_email_attachment.legacy_event_id
    IS 'EVENT_A identity key.';
COMMENT ON COLUMN camdaux.legacy_email_attachment.attachment_name
    IS 'Attachment (File) Name of the attachment.';
COMMENT ON COLUMN camdaux.legacy_email_attachment.attachment_clob
    IS 'CLOB (TEXT_CONTENT) for the attachment.';
COMMENT ON COLUMN camdaux.legacy_email_attachment.attachment_blob
    IS 'BLOB (BINARY_CONTENT) for the attachment.';