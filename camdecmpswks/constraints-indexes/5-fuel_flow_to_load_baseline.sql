ALTER TABLE IF EXISTS camdecmpswks.fuel_flow_to_load_baseline
    ADD CONSTRAINT pk_fuel_flow_to_load_baseline PRIMARY KEY (fuel_flow_baseline_id),
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_fuel_flow_load_uom FOREIGN KEY (fuel_flow_load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_ghr_uom FOREIGN KEY (ghr_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_test_sum_id
    ON camdecmpswks.fuel_flow_to_load_baseline USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_fuel_flow_load_uom_cd
    ON camdecmpswks.fuel_flow_to_load_baseline USING btree
    (fuel_flow_load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_ghr_uom_cd
    ON camdecmpswks.fuel_flow_to_load_baseline USING btree
    (ghr_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
