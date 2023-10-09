CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_matsweekly
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    weekly_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    system_component_identifier character varying(3) COLLATE pg_catalog."default",
    system_component_type character varying(1000) COLLATE pg_catalog."default",
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    test_type character varying(7) COLLATE pg_catalog."default",
    test_result character varying(7) COLLATE pg_catalog."default",
    span_scale character varying(7) COLLATE pg_catalog."default",
    gas_level character varying(7) COLLATE pg_catalog."default",
    ref_value numeric(13,2),
    measured_value numeric(13,3),
    system_integrity_error numeric(5,1),
    ERROR_CODES character varying(1) COLLATE pg_catalog."default"
);