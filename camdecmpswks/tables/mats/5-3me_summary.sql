-- Table: camdecmpswks.3me_summary

-- DROP TABLE camdecmpswks.3me_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.3me_summary
(
    3me_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
-- GAS LEVEL MENTIONED IN DOC BUT NOT IN SCHEMA SO NEED TO CONFIRM
    gas_level_cd character varying(7) NOT NULL,
    mean_measured_value numeric(13,3),
    mean_ref_value numeric(13,3),
    percent_error numeric(5,1),
    ref_gas_equivalent_concentration numeric(8,3),
    calc_mean_concentration numeric(8,3),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_3me_summary PRIMARY KEY (3me_sum_id),
    CONSTRAINT fk_3me_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_3me_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
-- GAS LEVEL MENTIONED IN DOC BUT NOT IN SCHEMA SO NEED TO CONFIRM
    CONSTRAINT ck_3me_summary_gas_level_code CHECK(gas_level_cd = ANY(ARRAY['ZERO', 'MID', 'HIGH']))
);
