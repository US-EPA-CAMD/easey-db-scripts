-- Table: camdecmpswks.emission_view_so2cems

-- DROP TABLE camdecmpswks.emission_view_so2cems;

CREATE TABLE camdecmpswks.emission_view_so2cems
(
    em_so2_cems_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    unadj_so2 numeric(13,3),
    so2_baf numeric(5,3),
    rpt_adj_so2 numeric(13,3),
    calc_adj_so2 numeric(13,3),
    so2_modc character varying(7) COLLATE pg_catalog."default",
    so2_pma numeric(4,1),
    unadj_flow numeric(13,3),
    flow_baf numeric(5,3),
    rpt_adj_flow numeric(13,3),
    adj_flow_used numeric(13,3),
    flow_modc character varying(7) COLLATE pg_catalog."default",
    flow_pma numeric(4,1),
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    so2_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_so2_mass_rate numeric(14,4),
    calc_so2_mass_rate numeric(14,4),
    calc_hi_rate numeric(14,4),
    default_so2_emission_rate numeric(15,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);