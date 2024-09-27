CREATE TABLE IF NOT EXISTS camddmw.op_year
(
  op_year  numeric(4,0) NOT NULL,
  archive_ind  numeric(1,0) NOT NULL default 0,
  hourly_data_ind numeric(1,0) NOT NULL default 1
);

COMMENT ON TABLE camddmw.op_year
    IS 'Contains list of available years for emissions data.';

COMMENT ON COLUMN camddmw.op_year.op_year IS 'Year in which data was collected';
COMMENT ON COLUMN camddmw.op_year.archive_ind IS 'Indicates whether emissions data related to the year reside in the archive schema.  0 for false, 1 for true';
COMMENT ON COLUMN camddmw.op_year.hourly_data_ind IS 'Identifies if hourly data exists for a year.  0 for false, 1 for true';
