CREATE TABLE IF NOT EXISTS CAMD.PRE_ECMPS_UNIT_QUARTER
(
  UNIT_ID               NUMERIC(12)                     NOT NULL,
  OP_YEAR               NUMERIC(4)                      NOT NULL,
  OP_QUARTER            NUMERIC(1)                      NOT NULL,
  COUNT_OP_TIME         NUMERIC(10),
  SUM_OP_TIME           NUMERIC(10,2),
  NUM_MONTHS_REPORTED   NUMERIC,
  RPT_PERIOD_ID         NUMERIC(38),
  USERID                VARCHAR(8),
  ADD_DATE              TIMESTAMP WITHOUT TIME ZONE,
  LOAD_DATE             TIMESTAMP WITHOUT TIME ZONE     DEFAULT NOW()::timestamp NOT NULL
);


COMMENT ON TABLE CAMD.PRE_ECMPS_UNIT_QUARTER IS 'Quarterly emissions data at the unit level.';


COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.UNIT_ID IS 'Unique identifier of a unit.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.OP_YEAR IS 'Year in which data was collected.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.OP_QUARTER IS 'Quarter in which data was collected.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.COUNT_OP_TIME IS 'NUMERIC of hours (>0) during which the unit operated for this time interval.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.SUM_OP_TIME IS 'Sum of hours of operation for this time interval.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.NUM_MONTHS_REPORTED IS 'Count of months in the quarter for which the unit has reported emissions.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.RPT_PERIOD_ID IS 'Reporting Period table id for the data.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.USERID IS 'Initials of user who last modified data.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.ADD_DATE IS 'Date on which the record was added.';
COMMENT ON COLUMN CAMD.PRE_ECMPS_UNIT_QUARTER.LOAD_DATE IS 'Date and time in which record was loaded from source.';
