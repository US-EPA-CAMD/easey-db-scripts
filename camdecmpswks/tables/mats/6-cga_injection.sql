-- Table: camdecmpswks.cga_injection

-- DROP TABLE camdecmpswks.cga_injection;

CREATE TABLE IF NOT EXISTS camdecmpswks.cga_injection
(
    cga_injection_id character varying(45) NOT NULL,
    cga_sum_id character varying(45) NOT NULL,
    injection_date date,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    native_hcl_before numeric(8,3),
    native_hcl_after numeric(8,3),
    calibration_cell_path_length numeric(8,3),
    stack_optical_path_length numeric(8,3),
    calibration_cell_temperature numeric(5,1),
    stack_cell_temperature numeric(5,1),
    calibraiton_cell_pressure numeric(5,2),
    stack_cell_pressure numeric(5,2),
    instrument_line_strength_factor numeric(8,3),
    equivalent_concentration numeric(8,3),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_cga_injection PRIMARY KEY (cga_injection_id),
    CONSTRAINT fk_cga_injection_cga_summary FOREIGN KEY (cga_sum_id)
        REFERENCES camdecmpswks.cga_summary (cga_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
);
