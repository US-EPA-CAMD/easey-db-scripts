-- Table: camdecmpswks.aca_attenuation

-- DROP TABLE camdecmpswks.aca_attenuation;

CREATE TABLE IF NOT EXISTS camdecmpswks.aca_attenuation
(
    aca_attenuation_id character varying(45) NOT NULL,
    aca_sum_id character varying(45) NOT NULL,
    attenuation_date date,
    attenuation_hour numeric(2,0),
    attenuation_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_aca_attenuation PRIMARY KEY (aca_attenuation_id),
    CONSTRAINT fk_aca_attenuation_aca_summary FOREIGN KEY (aca_sum_id)
        REFERENCES camdecmpswks.aca_summary (aca_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
);
