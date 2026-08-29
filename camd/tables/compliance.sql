CREATE TABLE IF NOT EXISTS camd.compliance
(
    unit_id numeric(38,0) NOT NULL,
    prg_code varchar(8) NOT NULL,
    ppl_id numeric(38,0),
    comp_year char(4 byte) NOT NULL,
    comp_response_ind numeric(1,0),
    cert_date timestamp without time zone,
    resub_ind numeric(1,0),
    subaccount_expl_ind numeric(1,0),
    nox_emissions_expl_ind numeric(1,0),
    monitoring_plan_expl_ind numeric(1,0),
    common_stack_expl_ind numeric(1,0),
    alternate_method_expl_ind numeric(1,0),
    explanation varchar(2500),
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    PRIMARY KEY (unit_id, prg_code, comp_year)
);
COMMENT ON TABLE camd.compliance
    IS 'Captures data submitted by users certifying compliance with CAMD programs.';
COMMENT ON COLUMN camd.compliance.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camd.compliance.prg_code
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.  ';
COMMENT ON COLUMN camd.compliance.ppl_id
    IS 'PEOPLE identity key.';
COMMENT ON COLUMN camd.compliance.comp_year
    IS 'Year for compliance certification.';
COMMENT ON COLUMN camd.compliance.comp_response_ind
    IS 'Response for whether unit was certified for compliance (yes or no).';
COMMENT ON COLUMN camd.compliance.cert_date
    IS 'Date on which a compliance certification was submitted.';
COMMENT ON COLUMN camd.compliance.resub_ind
    IS 'Identifies whether a compliance certification is a resubmission.';
COMMENT ON COLUMN camd.compliance.subaccount_expl_ind
    IS 'Explanation for why unit was not certified for compliance (account).';
COMMENT ON COLUMN camd.compliance.nox_emissions_expl_ind
    IS 'Explanation for why unit was not certified for compliance (NOx emissions).';
COMMENT ON COLUMN camd.compliance.monitoring_plan_expl_ind
    IS 'Explanation for why unit was not certified for compliance (monitoring plan).';
COMMENT ON COLUMN camd.compliance.common_stack_expl_ind
    IS 'Explanation for why unit was not certified for compliance (common stack).';
COMMENT ON COLUMN camd.compliance.alternate_method_expl_ind
    IS 'Reason why unit was not certified for compliance (alternate method).';
COMMENT ON COLUMN camd.compliance.explanation
    IS 'Text description for why unit was not certified for compliance.';
COMMENT ON COLUMN camd.compliance.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camd.compliance.update_date
    IS 'Date record was updated.';
COMMENT ON COLUMN camd.compliance.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';