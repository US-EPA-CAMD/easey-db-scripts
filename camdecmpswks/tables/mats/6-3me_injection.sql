-- Table: camdecmpswks.3me_injection

-- DROP TABLE camdecmpswks.3me_injection;

CREATE TABLE IF NOT EXISTS camdecmpswks.3me_injection
(
    3me_injection_id character varying(45) NOT NULL,
    3me_sum_id character varying(45) NOT NULL,
    injection_date date,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    native_hcl_before numeric(8,3),
    native_hcl_after numeric(8,3),
    calibration_cell_path_length numeric(8,3),
    stack_optical_path_length numeric(8,3),
    instrument_line_strength_factor numeric(8,3),
    calibration_cell_temperature numeric(5,1),
    stack_temperature numeric(5,1),
    calibration_cell_pressure numeric(5,2),
    stack_pressure numeric(5,2),
    measurement_error numeric(8,3),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_3me_injection PRIMARY KEY (3me_injection_id),
    CONSTRAINT fk_3me_injection_3me_summary FOREIGN KEY (3me_sum_id)
        REFERENCES camdecmpswks.3me_summary (3me_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
);
