CREATE TABLE IF NOT EXISTS camdecmpscalc.summary_value
(
    pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    parameter_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    calc_current_rpt_period_total numeric(13,3),
    calc_os_total numeric(13,3),
    calc_year_total numeric(13,3)
);
