CREATE TABLE IF NOT EXISTS CAMDDMW.BANK_DIM
(
  ACCOUNT_NUMBER            VARCHAR(12)                     NOT NULL,
  PRG_CODE                  VARCHAR(8)                      NOT NULL,
  CALENDAR_YEAR             NUMERIC(4),
  TOTAL_ALLOWANCE_RECEIVED  NUMERIC(10),
  COUNT_OF_RECEIVED         NUMERIC(10),
  TOTAL_ALLOWANCE_SOLD      NUMERIC(10),
  COUNT_OF_SOLD             NUMERIC(10),
  DATA_SOURCE               VARCHAR(35),
  USERID                    VARCHAR(8),
  ADD_DATE                  TIMESTAMP WITHOUT TIME ZONE
);


COMMENT ON TABLE CAMDDMW.BANK_DIM IS 'Annual summary allowance data for each account in a program';


COMMENT ON COLUMN CAMDDMW.BANK_DIM.COUNT_OF_RECEIVED IS 'Number of trades in which the account was the buying party';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.TOTAL_ALLOWANCE_SOLD IS 'Total number of allowances sold in calendar year';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.COUNT_OF_SOLD IS 'Number of trades in which the account was the selling party';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.DATA_SOURCE IS 'Source of the data';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.USERID IS 'Initials of user who last modified data';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.ADD_DATE IS 'Date on which the record was added';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.ACCOUNT_NUMBER IS 'Account number';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.PRG_CODE IS 'Program code';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.CALENDAR_YEAR IS 'Calendar year of the activity';
COMMENT ON COLUMN CAMDDMW.BANK_DIM.TOTAL_ALLOWANCE_RECEIVED IS 'Total number of allowances received for calendar year';
