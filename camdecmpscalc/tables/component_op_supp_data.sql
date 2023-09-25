CREATE TABLE IF NOT EXISTS camdecmpscalc.component_op_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_supp_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    days numeric(38,0) NOT NULL,
    hours numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);
