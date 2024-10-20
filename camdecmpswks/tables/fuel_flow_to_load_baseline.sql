CREATE TABLE IF NOT EXISTS camdecmpswks.fuel_flow_to_load_baseline
(
    fuel_flow_baseline_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    accuracy_test_number character varying(18) COLLATE pg_catalog."default",
    pei_test_number character varying(18) COLLATE pg_catalog."default",
    avg_fuel_flow_rate numeric(10,1),
    avg_load numeric(6,0),
    baseline_fuel_flow_load_ratio numeric(6,2),
    avg_hrly_hi_rate numeric(7,1),
    baseline_ghr numeric(6,0),
    nhe_cofiring numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_low_range numeric(4,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    fuel_flow_load_uom_cd character varying(7) COLLATE pg_catalog."default",
    ghr_uom_cd character varying(7) COLLATE pg_catalog."default"
);
