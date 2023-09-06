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
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_qa_supp_attribute_qa_supp_data_id
    ON camdecmpswks.qa_supp_attribute USING btree
    (qa_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;