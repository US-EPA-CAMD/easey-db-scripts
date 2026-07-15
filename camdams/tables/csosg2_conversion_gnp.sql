CREATE TABLE IF NOT EXISTS camdams.csosg2_conversion_gnp
(
    conversion_factor numeric(2,0),
    freeze_ind numeric(38,0) NOT NULL DEFAULT 0,
    freeze_date timestamp without time zone,
    notification_ind numeric(38,0) NOT NULL DEFAULT 0,
    process_ind numeric(38,0) NOT NULL DEFAULT 0,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone
);
COMMENT ON TABLE camdams.csosg2_conversion_gnp
    IS 'Stores information related to the GNP conversion of banked CSOSG2 allowances.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.freeze_ind
    IS 'Indicates if CSOSG2 allowance transfers are frozen.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.freeze_date
    IS 'Date CSOSG2 allowance transfers were frozen.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.notification_ind
    IS 'Indicates if the conversion notification has been sent.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.process_ind
    IS 'Indicates if the conversion transactions have been processed.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.csosg2_conversion_gnp.update_date
    IS 'Date of the last record update.';