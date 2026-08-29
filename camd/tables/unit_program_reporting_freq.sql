CREATE TABLE IF NOT EXISTS camd.unit_program_reporting_freq
(
    uprf_id numeric NOT NULL,
    up_id numeric NOT NULL,
    report_freq varchar(2) NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    PRIMARY KEY (uprf_id)
);
COMMENT ON TABLE camd.unit_program_reporting_freq
    IS 'Used to track reporting frequency for a unit-program.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.uprf_id
    IS 'Identity key for UNIT_PROGRAM_REPO';
COMMENT ON COLUMN camd.unit_program_reporting_freq.up_id
    IS 'Identity key for UNIT_PROGRAM table.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.report_freq
    IS 'Reporting frequency for a unit-program.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.begin_date
    IS 'Date on which a relationship or an activity began.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.end_date
    IS 'Date on which a relationship or an activity ended.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camd.unit_program_reporting_freq.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';