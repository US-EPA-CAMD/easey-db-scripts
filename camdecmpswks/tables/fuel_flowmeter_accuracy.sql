CREATE TABLE IF NOT EXISTS camdecmpswks.fuel_flowmeter_accuracy
(
    fuel_flow_acc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    acc_test_method_cd character varying(7) COLLATE pg_catalog."default",
    reinstall_date date,
    reinstall_hour numeric(2,0),
    low_fuel_accuracy numeric(5,1),
    mid_fuel_accuracy numeric(5,1),
    high_fuel_accuracy numeric(5,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
