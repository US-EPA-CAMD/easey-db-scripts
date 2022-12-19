-- Table: camdecmps.emission_view_co2dailyfuel

-- DROP TABLE camdecmps.emission_view_co2dailyfuel;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_co2dailyfuel
(
    em_co2_daily_fuel_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date date NOT NULL,
    rpt_total_daily_co2_mass numeric(10,1),
    rpt_unadjusted_co2_mass numeric(10,1),
    rpt_adjusted_daily_co2_mass numeric(10,1),
    rpt_sorbent_rltd_co2_mass numeric(10,1),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    daily_fuel_feed numeric(13,1),
    carbon_content_used numeric(5,1),
    fuel_carbon_burned numeric(13,1),
    calc_fuel_carbon_burned numeric(13,1),
    total_carbon_burned numeric(13,1),
    calc_total_daily_emission numeric(10,1)
);