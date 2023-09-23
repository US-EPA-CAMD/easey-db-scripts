CREATE TABLE IF NOT EXISTS camdecmps.fuel_flowmeter_accuracy
(
    fuel_flow_acc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    acc_test_method_cd character varying(7) COLLATE pg_catalog."default",
    reinstall_date date,
    reinstall_hour numeric(2,0),
    low_fuel_accuracy numeric(5,1),
    mid_fuel_accuracy numeric(5,1),
    high_fuel_accuracy numeric(5,1),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.fuel_flowmeter_accuracy
    IS 'Fuel flow meter accuracy test results for meters calibrated with a flowing fluid.  Record Type 627.';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.fuel_flow_acc_id
    IS 'Unique identifier of fuel flowmeter accuracy record. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.acc_test_method_cd
    IS 'Code used to indicate fuel flowmeter accuracy test method. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.reinstall_date
    IS 'Date in which fuel flow meter was reinstalled. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.reinstall_hour
    IS 'Hour in which fuel flow meter was reinstalled. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.low_fuel_accuracy
    IS 'Highest accuracy at low fuel flow rate (% of URV). ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.mid_fuel_accuracy
    IS 'Highest accuracy at mid fuel flowrate (% of URV). ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.high_fuel_accuracy
    IS 'Highest accuracy at high fuel flow rate (% of URV). ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.fuel_flowmeter_accuracy.update_date
    IS 'Date and time in which record was last updated. ';
