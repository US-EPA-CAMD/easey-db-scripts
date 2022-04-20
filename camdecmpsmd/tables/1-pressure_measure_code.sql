-- Table: camdecmpsmd.pressure_measure_code

-- DROP TABLE camdecmpsmd.pressure_measure_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.pressure_measure_code
(
    pressure_meas_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    pressure_meas_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_pressure_measure_code PRIMARY KEY (pressure_meas_cd)
);

COMMENT ON TABLE camdecmpsmd.pressure_measure_code
    IS 'Lookup table of pressure measurement device type codes.';

COMMENT ON COLUMN camdecmpsmd.pressure_measure_code.pressure_meas_cd
    IS 'Code used to identify a pressure measurement device type. ';

COMMENT ON COLUMN camdecmpsmd.pressure_measure_code.pressure_meas_cd_description
    IS 'Description of pressure measurement code. ';