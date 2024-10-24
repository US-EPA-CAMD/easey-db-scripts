CREATE TABLE IF NOT EXISTS camdecmps.emission_view_hiappd
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default",
    fuel_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_use_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    rpt_fuel_flow numeric(10,1),
    calc_fuel_flow numeric(10,1),
    fuel_flow_uom character varying(7) COLLATE pg_catalog."default",
    fuel_flow_sodc character varying(7) COLLATE pg_catalog."default",
    gross_calorific_value numeric(13,5),
    gcv_uom character varying(7) COLLATE pg_catalog."default",
    gcv_sampling_type character varying(7) COLLATE pg_catalog."default",
    formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_hi_rate numeric(13,5),
    calc_hi_rate numeric(13,5),
    ERROR_CODES character varying(1) COLLATE pg_catalog."default"
) PARTITION BY RANGE (rpt_period_id);
