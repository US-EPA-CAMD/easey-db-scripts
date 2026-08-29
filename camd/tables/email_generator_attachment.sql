CREATE TABLE IF NOT EXISTS camd.email_generator_attachment
(
    email_gen_attach_id numeric(38,0) NOT NULL,
    email_gen_attach_desc varchar(1000) NOT NULL,
    file_name varchar(100) NOT NULL,
    binary_content blob NOT NULL,
    PRIMARY KEY (email_gen_attach_id)
);
COMMENT ON TABLE camd.email_generator_attachment
    IS 'Look up table for email generator attachments that can be added to events.';
COMMENT ON COLUMN camd.email_generator_attachment.email_gen_attach_id
    IS 'Identity key for Email Generator ATTACHMENT table.';
COMMENT ON COLUMN camd.email_generator_attachment.email_gen_attach_desc
    IS 'Description for Email Generator attachment type.';
COMMENT ON COLUMN camd.email_generator_attachment.file_name
    IS 'File name for a fixed attachment.';
COMMENT ON COLUMN camd.email_generator_attachment.binary_content
    IS 'Content of a fixed binary attachment.';