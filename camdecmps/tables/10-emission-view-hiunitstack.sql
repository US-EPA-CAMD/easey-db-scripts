-- Table: camdecmps.emission_view_hiunitstack

-- DROP TABLE camdecmps.emission_view_hiunitstack;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_hiunitstack
(
    em_hi_unitstack_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    load_range integer,
    common_stack_load_range integer,
    hi_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_hi_rate numeric(14,4),
    calc_hi_rate numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);