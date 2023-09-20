CREATE TABLE camdecmps.operating_supp_data
(
    op_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    op_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.operating_supp_data
    IS 'Contains summary information about unit/stack/pipe operating hours and fuel hours by quarter for use by the emissions evaluation routines';

COMMENT ON COLUMN camdecmps.operating_supp_data.op_supp_data_id
    IS 'Unique identifier of an operating supplemental data record. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.op_type_cd
    IS 'Code used to identify the operating type. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.op_value
    IS 'Number of hours (or other units) corresponding to the calendar year, quarter and operating type code. ';

COMMENT ON COLUMN camdecmps.operating_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.operating_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.operating_supp_data.update_date
    IS 'Date and time in which record was last updated.';
