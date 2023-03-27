-- Table: camdecmpswks.dsa_summary

-- DROP TABLE camdecmpswks.dsa_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.dsa_summary
(
    dsa_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    gas_level_cd character varying(7) NOT NULL,
    mean_measured_value numeric(13,3),
    mean_ref_value numeric(13,3),
    dynamic_spike_error numeric(5,1),
    aps_ind numeric(1,0),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_dsa_summary PRIMARY KEY (dsa_sum_id),
    CONSTRAINT fk_dsa_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_dsa_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    CONSTRAINT ck_dsa_summary_gas_level_code CHECK(gas_level_cd = ANY(ARRAY['ZERO', 'MID', 'HIGH']))
);
