-- Table: camdecmpswks.beam_intensity

-- DROP TABLE camdecmpswks.beam_intensity;

CREATE TABLE IF NOT EXISTS camdecmpswks.beam_intensity
(
    beam_intensity_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    attenuation_value numeric(5,1),
    high_level_gas_concentration numeric(8,3),
    beam_intensity_full numeric(8,3),
    beam_intensity_attenuation numeric(8,3),
    beam_intensity_uom_cd character varying(7) NOT NULL,
    hcl_concentration_full numeric(8,3),
    hcl_concentration_attenuated numeric(8,3),
    percent_difference numeric(5,1),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_beam_intensity PRIMARY KEY (beam_intensity_id),
    CONSTRAINT fk_beam_intensity_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_beam_intensity_beam_intensity_uom FOREIGN KEY (beam_intensity_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
);
