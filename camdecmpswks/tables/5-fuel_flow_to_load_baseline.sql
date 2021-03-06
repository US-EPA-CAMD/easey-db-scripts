-- Table: camdecmpswks.fuel_flow_to_load_baseline

-- DROP TABLE camdecmpswks.fuel_flow_to_load_baseline;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    fuel_flow_load_uom_cd character varying(7) COLLATE pg_catalog."default",
    ghr_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_fuel_flow_to_load_baseline PRIMARY KEY (fuel_flow_baseline_id),
    CONSTRAINT fk_fuel_flow_to_load_baseline_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_flow_to_load_baseline_fuel_flow_load_uom FOREIGN KEY (fuel_flow_load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_flow_to_load_baseline_ghr_uom FOREIGN KEY (ghr_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_ffload_baseline_001

-- -- DROP INDEX camdecmpswks.idx_ffload_baseline_001;

-- CREATE INDEX idx_ffload_baseline_001
--     ON camdecmpswks.fuel_flow_to_load_baseline USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_fuel_flow_to_lo_fuel_flow

-- -- DROP INDEX camdecmpswks.idx_fuel_flow_to_lo_fuel_flow;

-- CREATE INDEX idx_fuel_flow_to_lo_fuel_flow
--     ON camdecmpswks.fuel_flow_to_load_baseline USING btree
--     (fuel_flow_load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_fuel_flow_to_lo_ghr_uom_cd

-- -- DROP INDEX camdecmpswks.idx_fuel_flow_to_lo_ghr_uom_cd;

-- CREATE INDEX idx_fuel_flow_to_lo_ghr_uom_cd
--     ON camdecmpswks.fuel_flow_to_load_baseline USING btree
--     (ghr_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
