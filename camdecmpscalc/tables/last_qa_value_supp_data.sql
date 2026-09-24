CREATE TABLE IF NOT EXISTS camdecmpscalc.last_qa_value_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    moisture_basis character varying(7) COLLATE pg_catalog."default",
    hourly_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    op_datehour timestamp without time zone NOT NULL,
    unadjusted_hrly_value numeric(13,3),
    adjusted_hrly_value numeric(13,3),
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);
