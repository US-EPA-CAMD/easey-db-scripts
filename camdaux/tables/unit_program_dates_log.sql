CREATE TABLE IF NOT EXISTS camdaux.unit_program_dates_log
(
    up_dates_log_id numeric(38,0) NOT NULL,
    up_id numeric(38,0) NOT NULL,
    current_umcbd timestamp without time zone NOT NULL,
    proposed_umcbd timestamp without time zone NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (up_dates_log_id)
);
COMMENT ON TABLE camdaux.unit_program_dates_log
    IS 'Logs proposed changes to UMCBD values that were not made by the overnight unit program dates job (or other actions that change unit program dates but do not wish to alter the existing UMCBD value.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.up_dates_log_id
    IS 'Unique key for unit program dates log record.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.up_id
    IS 'UNIT and PROGRAM relationship identity key.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.current_umcbd
    IS 'Current value for the date beginning timeline for completion of certification testing.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.proposed_umcbd
    IS 'Proposed new value for the date beginning timeline for completion of certification testing.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdaux.unit_program_dates_log.add_date
    IS 'Date the record was created.';