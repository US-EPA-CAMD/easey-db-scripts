CREATE TABLE IF NOT EXISTS camdecmps.monitor_qualification_cpms(
  mon_qual_cpms_id character varying(45) NOT NULL,
  mon_qual_id character varying(45) NOT NULL,
	qual_data_year numeric(4,0) NOT NULL,
	stack_test_number character varying(18) NOT NULL,
	operating_limit numeric(6,1) NOT NULL,
  userid character varying(25) NOT NULL,
  add_date timestamp without time zone,
  update_date timestamp without time zone
);