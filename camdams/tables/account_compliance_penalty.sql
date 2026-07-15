CREATE TABLE IF NOT EXISTS camdams.account_compliance_penalty
(
    account_comp_id numeric(38,0) NOT NULL,
    penalty_amount numeric(15,3) NOT NULL,
    PRIMARY KEY (account_comp_id)
);
COMMENT ON TABLE camdams.account_compliance_penalty
    IS 'Lists penalty dollar amount for specific account compliance records.';
COMMENT ON COLUMN camdams.account_compliance_penalty.account_comp_id
    IS 'Identity key for account compliance table.';
COMMENT ON COLUMN camdams.account_compliance_penalty.penalty_amount
    IS 'Dollar amount of penalty.';