CREATE TABLE IF NOT EXISTS camdecmps.emission_view_co2calc
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    co2c_modc character varying(7) COLLATE pg_catalog."default",
    co2c_pma numeric(4,1),
    rpt_pct_o2 numeric(13,3),
    pct_o2_used numeric(5,1),
    o2_modc character varying(7) COLLATE pg_catalog."default",
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    fc_factor numeric(8,1),
    fd_factor numeric(8,1),
    formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_pct_co2 numeric(14,4),
    calc_pct_co2 numeric(14,4),
    ERROR_CODES character varying(1) COLLATE pg_catalog."default"
) PARTITION BY RANGE (rpt_period_id);
