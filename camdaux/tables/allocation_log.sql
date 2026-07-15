CREATE TABLE IF NOT EXISTS camdaux.allocation_log
(
    allocation_log_id numeric(38,0) NOT NULL,
    authority_year_id numeric(38,0),
    allocation_date timestamp without time zone,
    userid varchar(160),
    PRIMARY KEY (allocation_log_id)
);
COMMENT ON TABLE camdaux.allocation_log
    IS 'Log of allocation events.';
COMMENT ON COLUMN camdaux.allocation_log.allocation_log_id
    IS 'Identity key for account table.';
COMMENT ON COLUMN camdaux.allocation_log.authority_year_id
    IS 'Identity key for authority year table.';
COMMENT ON COLUMN camdaux.allocation_log.allocation_date
    IS 'Date of allocation transaction.';
COMMENT ON COLUMN camdaux.allocation_log.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';