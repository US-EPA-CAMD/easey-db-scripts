CREATE TABLE IF NOT EXISTS camdecmpscalc.operating_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    parameter_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    op_type_cd character varying(7) COLLATE pg_catalog."default",
    op_value numeric(13,3)
);
