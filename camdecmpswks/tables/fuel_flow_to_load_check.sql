CREATE TABLE IF NOT EXISTS camdecmpswks.fuel_flow_to_load_check
(
    fuel_flow_load_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_basis_cd character varying(7) COLLATE pg_catalog."default",
    avg_diff numeric(5,1),
    num_hrs numeric(4,0),
    nhe_cofiring numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_low_range numeric(4,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);