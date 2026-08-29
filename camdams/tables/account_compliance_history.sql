CREATE TABLE IF NOT EXISTS camdams.account_compliance_history
(
    account_comp_id numeric(38,0) NOT NULL,
    begin_balance numeric(15,0) NOT NULL,
    end_balance numeric(15,0) NOT NULL,
    balance_cd varchar(7) NOT NULL,
    prg_vintage_id numeric(38,0),
    emiss_liability numeric(15,3) NOT NULL,
    underutilization_liability numeric(15,3),
    offset_liability numeric(15,0),
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userid varchar(160) NOT NULL
);
COMMENT ON TABLE camdams.account_compliance_history
    IS 'Lists compliance records by account id and compliance period for each final compliance run.';
COMMENT ON COLUMN camdams.account_compliance_history.account_comp_id
    IS 'Identity key for account compliance table';
COMMENT ON COLUMN camdams.account_compliance_history.begin_balance
    IS 'Number of allowances of the current vintage or earlier held at compliance.';
COMMENT ON COLUMN camdams.account_compliance_history.end_balance
    IS 'Number of allowances of the current vintage or earlier held after compliance.';
COMMENT ON COLUMN camdams.account_compliance_history.balance_cd
    IS 'Balance code.';
COMMENT ON COLUMN camdams.account_compliance_history.prg_vintage_id
    IS 'Identity key for program vintage table.';
COMMENT ON COLUMN camdams.account_compliance_history.emiss_liability
    IS 'Emissions liability at compliance.';
COMMENT ON COLUMN camdams.account_compliance_history.underutilization_liability
    IS 'Underutilization liability.';
COMMENT ON COLUMN camdams.account_compliance_history.offset_liability
    IS 'Emissions not offset at compliance.';
COMMENT ON COLUMN camdams.account_compliance_history.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.account_compliance_history.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';