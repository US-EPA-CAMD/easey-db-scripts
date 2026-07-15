CREATE TABLE IF NOT EXISTS camd.applic_determination
(
    apd_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    app_status varchar(12),
    ppl_id numeric(38,0),
    rec_date timestamp without time zone,
    applic_source_code varchar(3),
    app_cd varchar(3),
    class varchar(2),
    comp_id numeric(38,0),
    PRIMARY KEY (apd_id)
);
COMMENT ON TABLE camd.applic_determination
    IS 'Stores information needed to determine Acid Rain Program applicability or exemption and applicability determination results.';
COMMENT ON COLUMN camd.applic_determination.apd_id
    IS 'Applicability determination identity key.';
COMMENT ON COLUMN camd.applic_determination.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camd.applic_determination.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camd.applic_determination.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camd.applic_determination.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camd.applic_determination.app_status
    IS 'Code for review status of Applicability Determination.';
COMMENT ON COLUMN camd.applic_determination.ppl_id
    IS 'PEOPLE identity key.';
COMMENT ON COLUMN camd.applic_determination.rec_date
    IS 'Data in which APPLICABILITY DETERMINATION request was received.';
COMMENT ON COLUMN camd.applic_determination.applic_source_code
    IS 'Source of Applicability Determination';
COMMENT ON COLUMN camd.applic_determination.app_cd
    IS 'Short abbreviation for APPLICATION name.';
COMMENT ON COLUMN camd.applic_determination.class
    IS 'The regulatory category with respect to a specific PROGRAM for a UNIT.';
COMMENT ON COLUMN camd.applic_determination.comp_id
    IS 'COMPANY identity key.';