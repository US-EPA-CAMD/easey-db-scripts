CREATE TABLE CAMDNATS.TCOMPPROB_TRANSACT
(
  TRANEVNT_CNT  NUMERIC(38)     NOT NULL,
  ACCTNUM_ID    CHAR(12)        NOT NULL,
  COMPYEAR_DT   NUMERIC(4)      NOT NULL,
  BLOCK_TOTAL   NUMERIC(15)     NOT NULL,
  TRANTYPE_CD   VARCHAR(2),
  ALLWTRANS_CD  VARCHAR(2),
  ALLWYEAR_DT   NUMERIC(4)
);

COMMENT ON TABLE CAMDNATS.TCOMPPROB_TRANSACT IS 'Lists NUMERIC of allowances deducted for each account and year for transactions that apply to multiple accounts and/or years.';

COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.TRANEVNT_CNT IS 'Transaction ID of the problem transaction.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.ACCTNUM_ID IS 'Account to which this transaction applies.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.COMPYEAR_DT IS 'Compliance Year to which this transaction applies.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.BLOCK_TOTAL IS 'Total NUMERIC of allowances deducted in this transaction for this account and compliance year.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.TRANTYPE_CD IS 'Transaction type code of allowances deducted for the specific account/year.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.ALLWTRANS_CD IS 'NUMERIC of allowances deducted for the specific account/year/type.';
COMMENT ON COLUMN CAMDNATS.TCOMPPROB_TRANSACT.ALLWYEAR_DT IS 'Allowance Year of allowance block deducted.';
