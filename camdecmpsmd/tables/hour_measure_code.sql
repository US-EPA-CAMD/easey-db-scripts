CREATE TABLE IF NOT EXISTS camdecmpsmd.hour_measure_code
(
    hour_measure_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    hour_measure_description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    unit_only character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::character varying
);

COMMENT ON TABLE camdecmpsmd.hour_measure_code
    IS 'Lookup table of codes that indicate how pollutant parameter values were measured.';

COMMENT ON COLUMN camdecmpsmd.hour_measure_code.hour_measure_cd
    IS 'Code indicating how the associated value was measured.';

COMMENT ON COLUMN camdecmpsmd.hour_measure_code.hour_measure_description
    IS 'Description of hour measure code.';

COMMENT ON COLUMN camdecmpsmd.hour_measure_code.unit_only
    IS 'Indicates whether the hour measure code is used for apportioned unit data only.';