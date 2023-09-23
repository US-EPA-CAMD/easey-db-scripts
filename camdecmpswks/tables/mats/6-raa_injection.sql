-- Table: camdecmpswks.raa_injection

-- DROP TABLE camdecmpswks.raa_injection;

CREATE TABLE IF NOT EXISTS camdecmpswks.raa_injection
(
    raa_injection_id character varying(45) NOT NULL,
    raa_sum_id character varying(45) NOT NULL,
    injection_date date,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    measured_value_uom_cd character varying(7) NOT NULL,
    ref_value numeric(13,3),
    ref_value_uom_cd character varying(7) NOT NULL,
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_raa_injection PRIMARY KEY (raa_injection_id),
    CONSTRAINT fk_raa_injection_raa_summary FOREIGN KEY (raa_sum_id)
        REFERENCES camdecmpswks.raa_summary (raa_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_raa_injection_measured_value_uom FOREIGN KEY (measured_value_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code(uom_cd) MATCH SIMPLE,
    CONSTRAINT fk_raa_injection_ref_value_uom FOREIGN KEY (ref_value_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code(uom_cd) MATCH SIMPLE
);
