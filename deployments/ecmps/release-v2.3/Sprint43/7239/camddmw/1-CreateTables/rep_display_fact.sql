CREATE TABLE CAMDDMW.REP_DISPLAY_FACT
(
  REP_FACT_ID           BIGSERIAL                       NOT NULL,
  UNIT_ID               NUMERIC(12),
  ACCOUNT_NUMBER        VARCHAR(12),
  PRG_CODE              VARCHAR(8)                      NOT NULL,
  OP_YEAR               NUMERIC(4)                      NOT NULL,
  PRM_DISPLAY_NAME      VARCHAR(1000),
  ALT_DISPLAY_NAME      VARCHAR(1000),
  PRM_DISPLAY_BLOCK     VARCHAR(2000),
  ALT_DISPLAY_BLOCK     VARCHAR(2000),
  DATA_SOURCE           VARCHAR(35),
  USERID                VARCHAR(8),
  ADD_DATE              TIMESTAMP WITHOUT TIME ZONE
)
PARTITION BY RANGE (OP_YEAR);


COMMENT ON TABLE CAMDDMW.REP_DISPLAY_FACT IS 'Representatives of units for an operating year aggregated by unit and year';


COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.REP_FACT_ID IS 'Identity key for REP_DISPLAY_FACT';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.UNIT_ID IS 'Unique identifier of a unit';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.ACCOUNT_NUMBER IS 'Account number';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.PRG_CODE IS 'Program code';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.OP_YEAR IS 'Year in which data was collected';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.PRM_DISPLAY_NAME IS 'Formatted display of primary representative name';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.ALT_DISPLAY_NAME IS 'Formatted display of alternate representative name';;
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.PRM_DISPLAY_BLOCK IS 'Formatted display of primary representative information, including name, affiliation, address, phone and fax number';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.ALT_DISPLAY_BLOCK IS 'Formatted display of alternate representative information, including name, affiliation, address, phone and fax number';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.DATA_SOURCE IS 'Source of the data';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.USERID IS 'Initials of user who last modified data';
COMMENT ON COLUMN CAMDDMW.REP_DISPLAY_FACT.ADD_DATE IS 'Date on which the record was added';
