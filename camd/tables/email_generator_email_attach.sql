CREATE TABLE IF NOT EXISTS camd.email_generator_email_attach
(
    email_gen_email_id numeric NOT NULL,
    email_gen_attach_id numeric NOT NULL,
    PRIMARY KEY (email_gen_email_id, email_gen_attach_id)
);
COMMENT ON TABLE camd.email_generator_email_attach
    IS 'Stores attachments for pending emails.';
COMMENT ON COLUMN camd.email_generator_email_attach.email_gen_email_id
    IS 'The EMail_GEN_EMAIL_ID in the Email Generator Email Table.';
COMMENT ON COLUMN camd.email_generator_email_attach.email_gen_attach_id
    IS 'The Attachment_ID in the Email Generator Email Attachment table.';