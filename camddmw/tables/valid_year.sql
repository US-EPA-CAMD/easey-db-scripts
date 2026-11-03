CREATE TABLE IF NOT EXISTS CAMDDMW.VALID_YEAR
(
  DATA_STATUS       CHAR(1),
  ENABLED           CHAR(1),
  HRLY              CHAR(1)     DEFAULT 'T',
  OP_QUARTER        INTEGER,
  VALID_YEAR        NUMERIC,
  ARCHIVE_IND       NUMERIC(1)  DEFAULT 0,
  UPDATE_LOCK_IND   NUMERIC(1)  DEFAULT 0
);


COMMENT ON TABLE CAMDDMW.VALID_YEAR IS 'List of valid years for accessing data in Data and Maps website.';


COMMENT ON COLUMN CAMDDMW.VALID_YEAR.DATA_STATUS IS 'Data is identified as either (P)reliminary or (F)inal';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.ENABLED IS 'Identifies if the data should be available for display on Data and Maps web site';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.HRLY IS 'Identifies if hourly data exists for a year';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.OP_QUARTER IS 'Quarter in which data was collected';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.VALID_YEAR IS 'Year currently active on the Data and Maps website';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.ARCHIVE_IND IS 'Indicates whether emissions data related to the row reside in the archive schema.';
COMMENT ON COLUMN CAMDDMW.VALID_YEAR.UPDATE_LOCK_IND IS 'Indicates whether updates of emissions have been locked for emissions data related to the row.';
