-- Table: camdecmpswks.qga_run

-- DROP TABLE camdecmpswks.qga_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.qga_run
(
    qga_run_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    gas_level_cd character varying(7) NOT NULL,
    calibration_gas_value numeric(8,3),
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    dilution_ratio numeric(8,3),
    sample_value numeric(8,3),
    mean_sample_value numeric(8,3),
    expected_value numeric(8,3),
    bias numeric(8,3),
    correction_factor numeric(8,3),
    spiked_indicator numeric(1,0),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_qga_run PRIMARY KEY (qga_sum_id),
    CONSTRAINT fk_qga_run_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_qga_run_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    CONSTRAINT ck_qga_run_gas_level_code CHECK(gas_level_cd = ANY(ARRAY['ZERO', 'HIGH']))
);
