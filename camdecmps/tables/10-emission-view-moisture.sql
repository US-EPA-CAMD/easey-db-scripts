-- Table: camdecmps.emission_view_moisture

-- DROP TABLE camdecmps.emission_view_moisture;

CREATE TABLE camdecmps.emission_view_moisture
(
    em_moisture_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    h2o_modc character varying(7) COLLATE pg_catalog."default",
    h2o_pma numeric(4,1),
    pct_o2_wet numeric(13,3),
    o2_wet_modc character varying(7) COLLATE pg_catalog."default",
    pct_o2_dry numeric(13,3),
    o2_dry_modc character varying(7) COLLATE pg_catalog."default",
    h2o_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_pct_h2o numeric(14,4),
    calc_pct_h2o numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);