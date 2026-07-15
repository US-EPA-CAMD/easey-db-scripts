CREATE TABLE IF NOT EXISTS camdams.nox_ael_limit
(
    unit_id numeric(38,0) NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    ael_limit numeric(5,2) NOT NULL,
    limit_cd varchar(2) NOT NULL,
    userid varchar(160) NOT NULL,
    update_date timestamp without time zone,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (unit_id, begin_date)
);
COMMENT ON TABLE camdams.nox_ael_limit
    IS 'Alternative NOx emission limit approved by the permitting authority for a specified time period under Part 76.  Used in lieu of standard NOx emission limit for applicable time period.';
COMMENT ON COLUMN camdams.nox_ael_limit.unit_id
    IS 'Identity key for unit table.';
COMMENT ON COLUMN camdams.nox_ael_limit.begin_date
    IS 'Date on which a relationship or an activity began. ';
COMMENT ON COLUMN camdams.nox_ael_limit.end_date
    IS 'Date on which a relationship or an activity ended.';
COMMENT ON COLUMN camdams.nox_ael_limit.ael_limit
    IS 'Alternative NOx emission limit.';
COMMENT ON COLUMN camdams.nox_ael_limit.limit_cd
    IS 'Designation of alternative NOx emissions limit as final or interim';
COMMENT ON COLUMN camdams.nox_ael_limit.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.nox_ael_limit.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.nox_ael_limit.add_date
    IS 'Date the record was created.';