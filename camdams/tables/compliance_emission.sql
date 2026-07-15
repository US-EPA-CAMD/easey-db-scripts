CREATE TABLE IF NOT EXISTS camdams.compliance_emission
(
    comp_emiss_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0),
    comp_period_id numeric(38,0) NOT NULL,
    parameter_cd varchar(7) NOT NULL,
    emiss_value numeric(15,3) NOT NULL,
    emiss_date timestamp without time zone,
    data_source_cd varchar(7) NOT NULL,
    approval_cd varchar(7),
    edit_reason varchar(4000),
    severity_cd varchar(7),
    value_source_cd varchar(7),
    stack_name varchar(6),
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (comp_emiss_id)
);
COMMENT ON TABLE camdams.compliance_emission
    IS 'Lists most recently loaded emissions number by unit_id or fac_id and parameter.';
COMMENT ON COLUMN camdams.compliance_emission.comp_emiss_id
    IS 'Identity key for compliance emission table.';
COMMENT ON COLUMN camdams.compliance_emission.fac_id
    IS 'Identity key for facility table.';
COMMENT ON COLUMN camdams.compliance_emission.unit_id
    IS 'Identity key for unit table.';
COMMENT ON COLUMN camdams.compliance_emission.comp_period_id
    IS 'Identity key for compliance period table.';
COMMENT ON COLUMN camdams.compliance_emission.parameter_cd
    IS 'Type of emissions or pollutant measured.';
COMMENT ON COLUMN camdams.compliance_emission.emiss_value
    IS 'Emissions.';
COMMENT ON COLUMN camdams.compliance_emission.emiss_date
    IS 'Date and time in which EMISS_VALUE was updated.';
COMMENT ON COLUMN camdams.compliance_emission.data_source_cd
    IS 'Indicates data loading method.';
COMMENT ON COLUMN camdams.compliance_emission.approval_cd
    IS 'Emissions approval code.';
COMMENT ON COLUMN camdams.compliance_emission.edit_reason
    IS 'Reason entered when emissions data is manually changed.';
COMMENT ON COLUMN camdams.compliance_emission.severity_cd
    IS 'ECMPS Check severity code for emissions file.';
COMMENT ON COLUMN camdams.compliance_emission.value_source_cd
    IS 'For ARP NOx compliance, this code indicates the source of the data including CS, CSNA, HOURLY, UNIT and MS for NOXR and only UN for HI.';
COMMENT ON COLUMN camdams.compliance_emission.stack_name
    IS 'Public Identifier for the stack.';
COMMENT ON COLUMN camdams.compliance_emission.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.compliance_emission.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.compliance_emission.update_date
    IS 'Date of the last record update.';