CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_qualification_lme
(
    mon_lme_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_data_year numeric(4,0) NOT NULL,
    so2_tons numeric(4,1),
    nox_tons numeric(4,1),
    op_hours numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
