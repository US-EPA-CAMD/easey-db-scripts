CREATE TABLE IF NOT EXISTS camdaux.email_action_attachment
(
    email_action_attachment_id numeric(38,0) NOT NULL,
    email_action_id numeric(38,0) NOT NULL,
    attachment_id numeric(38,0) NOT NULL,
    enabled_ind numeric(1,0) NOT NULL DEFAULT 1,
    PRIMARY KEY (email_action_attachment_id)
);
COMMENT ON TABLE camdaux.email_action_attachment
    IS 'Lookup table containing static email content for email actions.';
COMMENT ON COLUMN camdaux.email_action_attachment.email_action_attachment_id
    IS 'EMAIL_ACTION_ATTACHMENT identity key.';
COMMENT ON COLUMN camdaux.email_action_attachment.email_action_id
    IS 'EMAIL_ACTION identity key.';
COMMENT ON COLUMN camdaux.email_action_attachment.attachment_id
    IS 'ATTACHMENT identity key.';
COMMENT ON COLUMN camdaux.email_action_attachment.enabled_ind
    IS 'Indicates whether an EMAIL_ATTACHMENT_LOG record should be created for the email action and attachment content.';