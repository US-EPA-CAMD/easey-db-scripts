CREATE TABLE IF NOT EXISTS camdaux.event_a_update
(
    event_id numeric NOT NULL,
    event_status varchar(1),
    sent_date timestamp without time zone,
    email_log_id numeric(38,0),
    userid varchar(160) NOT NULL,
    update_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (event_id)
);
COMMENT ON TABLE camdaux.event_a_update
    IS 'Records updates to the archived EVENT_A table, which are used to override the currently arcived values.';
COMMENT ON COLUMN camdaux.event_a_update.event_id
    IS 'EVENT_A_UPDATE (and EVENT_A) identity key.';
COMMENT ON COLUMN camdaux.event_a_update.event_status
    IS 'Event status code.';
COMMENT ON COLUMN camdaux.event_a_update.sent_date
    IS 'Date on which email was sent.';
COMMENT ON COLUMN camdaux.event_a_update.email_log_id
    IS 'EMAIL_LOG identity key.  Specifies the EMAIL_LOG row that replaces the EVENT_A row for EVENT_ID.  Only populated for activated legacy row, not cloned rows.';
COMMENT ON COLUMN camdaux.event_a_update.userid
    IS 'The user name of the person or process that updated the record.';
COMMENT ON COLUMN camdaux.event_a_update.update_date
    IS 'Date the record was updated.';