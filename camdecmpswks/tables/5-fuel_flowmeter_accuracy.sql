-- Table: camdecmpswks.fuel_flowmeter_accuracy

-- DROP TABLE camdecmpswks.fuel_flowmeter_accuracy;

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
    update_date timestamp without time zone,
    CONSTRAINT pk_fuel_flowmeter_accuracy PRIMARY KEY (fuel_flow_acc_id),
    CONSTRAINT fk_fuel_flowmeter_accuracy_accuracy_test_method_code FOREIGN KEY (acc_test_method_cd)
        REFERENCES camdecmpsmd.accuracy_test_method_code (acc_test_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_flowmeter_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_ff_accuracy_001

-- -- DROP INDEX camdecmpswks.idx_ff_accuracy_001;

-- CREATE INDEX idx_ff_accuracy_001
--     ON camdecmpswks.fuel_flowmeter_accuracy USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_fuel_flowmeter_acc_test_m

-- -- DROP INDEX camdecmpswks.idx_fuel_flowmeter_acc_test_m;

-- CREATE INDEX idx_fuel_flowmeter_acc_test_m
--     ON camdecmpswks.fuel_flowmeter_accuracy USING btree
--     (acc_test_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
