CREATE TABLE IF NOT EXISTS camdecmps.monitor_qualification_pct
(
    mon_pct_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_year numeric(4,0) NOT NULL,
    yr1_qual_data_type_cd character varying(7) COLLATE pg_catalog."default",
    yr1_qual_data_year numeric(4,0),
    yr1_pct_value numeric(5,1),
    yr2_qual_data_type_cd character varying(7) COLLATE pg_catalog."default",
    yr2_qual_data_year numeric(4,0),
    yr2_pct_value numeric(5,1),
    yr3_qual_data_type_cd character varying(7) COLLATE pg_catalog."default",
    yr3_qual_data_year numeric(4,0),
    yr3_pct_value numeric(5,1),
    avg_pct_value numeric(5,1),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.monitor_qualification_pct
    IS 'Monitoring qualification data based on percentage of capacity or gas usage to qualify as peaking, or gas fired units. Record Type 507.';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.mon_pct_id
    IS 'Unique identifier of a monitoring qualification percentage record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.mon_qual_id
    IS 'Unique identifier of a monitoring qualification record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.qual_year
    IS 'Year corresponding to the qualification data. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr1_qual_data_type_cd
    IS 'Code used to identify the type qualification in the first year. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr1_qual_data_year
    IS 'The first year corresponding to the qualification data. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr1_pct_value
    IS 'The percent capacity or heat input usage in the first year. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr2_qual_data_type_cd
    IS 'Code used to identify the type qualification in the second year. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr2_qual_data_year
    IS 'The second year corresponding to the qualification data. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr2_pct_value
    IS 'The percent capacity or heat input usage in the second year. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr3_qual_data_type_cd
    IS 'Code used to indicate type of data for year (actual or projected) used to determine peaking or gas-fired qualification. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr3_qual_data_year
    IS 'The third year corresponding to the qualification data. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.yr3_pct_value
    IS 'The percent capacity or heat input usage in the third year. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.avg_pct_value
    IS 'The average percent capacity or heat input usage. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_pct.update_date
    IS 'Date and time in which record was last updated. ';
