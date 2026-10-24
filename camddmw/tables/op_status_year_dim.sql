CREATE TABLE IF NOT EXISTS CAMDDMW.OP_STATUS_YEAR_DIM
(
  UNIT_ID                   NUMERIC(12)                     NOT NULL,
  OP_YEAR                   NUMERIC(4)                      NOT NULL,
  OP_STATUS                 VARCHAR(7),
  OP_STATUS_DESCRIPTION     VARCHAR(30),
  DATA_SOURCE               VARCHAR(35),
  USERID                    VARCHAR(8),
  ADD_DATE                  TIMESTAMP WITHOUT TIME ZONE,
  LAST_UPDATE_DATE          TIMESTAMP WITHOUT TIME ZONE
)
PARTITION BY RANGE ( OP_YEAR );


COMMENT ON TABLE CAMDDMW.OP_STATUS_YEAR_DIM IS 'Operating status of a unit for an operating year';


COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.UNIT_ID IS 'Unique identifier of a unit';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.OP_YEAR IS 'Year in which data was collected';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.OP_STATUS IS 'Operating status code of unit for a given year';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.OP_STATUS_DESCRIPTION IS 'Text description of operating status including the effective date in which the status became effective (e.g.  Retired (Jan 2003) )';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.DATA_SOURCE IS 'Source of the data';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.USERID IS 'Initials of user who last modified data';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.ADD_DATE IS 'Date on which the record was added';
COMMENT ON COLUMN CAMDDMW.OP_STATUS_YEAR_DIM.LAST_UPDATE_DATE IS 'Latest add or update date on source records that are used to populate this record';
