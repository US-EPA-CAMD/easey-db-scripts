CREATE TABLE IF NOT EXISTS camdecmpswks.qa_cert_event_supp_data
(
    qa_cert_event_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    count_from_datehour timestamp without time zone NOT NULL,
    count numeric(38,0),
    count_from_included_ind numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
