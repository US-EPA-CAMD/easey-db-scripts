CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_qualification_pct
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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
