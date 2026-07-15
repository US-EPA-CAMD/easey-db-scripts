CREATE TABLE IF NOT EXISTS camdaux.email_send_queue
(
    email_log_id numeric(38,0) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    merged_xml_log_id numeric(38,0),
    PRIMARY KEY (email_log_id)
);
COMMENT ON TABLE camdaux.email_send_queue
    IS 'The EMAIL_SEND_QUEUE table stores a link to EMAIL_LOG rows that a user marked to send.';
COMMENT ON COLUMN camdaux.email_send_queue.email_log_id
    IS 'EMAIL_LOG identity key.';
COMMENT ON COLUMN camdaux.email_send_queue.userid
    IS 'The user name of the person or process that created the record.';
COMMENT ON COLUMN camdaux.email_send_queue.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdaux.email_send_queue.merged_xml_log_id
    IS 'XML_LOG identity key - populated as result of a merge action in CSA.';