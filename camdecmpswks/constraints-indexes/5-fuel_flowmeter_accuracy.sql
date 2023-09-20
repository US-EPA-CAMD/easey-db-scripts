ALTER TABLE IF EXISTS camdecmpswks.fuel_flowmeter_accuracy
    ADD CONSTRAINT pk_fuel_flowmeter_accuracy PRIMARY KEY (fuel_flow_acc_id),
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_accuracy_test_method_code FOREIGN KEY (acc_test_method_cd)
        REFERENCES camdecmpsmd.accuracy_test_method_code (acc_test_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flowmeter_accuracy_test_sum_id
    ON camdecmpswks.fuel_flowmeter_accuracy USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flowmeter_accuracy_acc_test_method_cd
    ON camdecmpswks.fuel_flowmeter_accuracy USING btree
    (acc_test_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
