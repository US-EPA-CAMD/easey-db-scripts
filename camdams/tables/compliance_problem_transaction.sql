CREATE TABLE IF NOT EXISTS camdams.compliance_problem_transaction
(
    comp_prob_trans_id numeric(38,0) NOT NULL,
    trans_id numeric(38,0) NOT NULL,
    account_comp_id numeric(38,0) NOT NULL,
    block_total numeric(15,0) NOT NULL,
    PRIMARY KEY (comp_prob_trans_id)
);
COMMENT ON TABLE camdams.compliance_problem_transaction
    IS 'Lists compliance transactions that apply to multiple account compliance records.';
COMMENT ON COLUMN camdams.compliance_problem_transaction.comp_prob_trans_id
    IS 'Identity key for compliance problem transaction table.';
COMMENT ON COLUMN camdams.compliance_problem_transaction.trans_id
    IS 'Transaction ID of the problem transaction.';
COMMENT ON COLUMN camdams.compliance_problem_transaction.account_comp_id
    IS 'Identity key for account compliance table.';
COMMENT ON COLUMN camdams.compliance_problem_transaction.block_total
    IS 'Total number of allowances deducted in this transaction for this account compliance record.';