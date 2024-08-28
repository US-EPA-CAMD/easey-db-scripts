CREATE TABLE IF NOT EXISTS camddmw.op_year
(
  op_year  numeric(4,0) NOT NULL,
  archive_ind  numeric(1,0) NOT NULL default 0,
  hourly_data_ind numeric(1,0) NOT NULL default 1,
CONSTRAINT pk_op_year PRIMARY KEY (op_year)
);
COMMENT ON COLUMN camddmw.op_year.archive_ind IS '0 for false,1 for true ';
COMMENT ON COLUMN camddmw.op_year.hourly_data_ind IS '0 for false,1 for true ';
