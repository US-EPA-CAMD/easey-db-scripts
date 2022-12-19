-- Table: camdecmps.emission_view_otherdaily

-- DROP TABLE camdecmps.emission_view_otherdaily;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_otherdaily
(
    em_other_daily_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    test_type_cd character varying(7) COLLATE pg_catalog."default",
    system_component_identifier character varying(3) COLLATE pg_catalog."default",
    system_component_type character varying(7) COLLATE pg_catalog."default",
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    rpt_test_result character varying(7) COLLATE pg_catalog."default" NOT NULL,
    error_codes character varying(1000) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default"
);