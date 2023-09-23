-- Table: camdecmpswks.dsa_injection

-- DROP TABLE camdecmpswks.dsa_injection;

CREATE TABLE IF NOT EXISTS camdecmpswks.dsa_injection
(
    dsa_injection_id character varying(45) NOT NULL,
    dsa_sum_id character varying(45) NOT NULL,
    injection_date date,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    dilution_factor numeric(8,3),
    nativeHCLBefore numeric(8,3),
    nativeHCLAfter numeric(8,3),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_dsa_injection PRIMARY KEY (dsa_injection_id),
    CONSTRAINT fk_dsa_injection_dsa_summary FOREIGN KEY (dsa_sum_id)
        REFERENCES camdecmpswks.dsa_summary (dsa_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
);
