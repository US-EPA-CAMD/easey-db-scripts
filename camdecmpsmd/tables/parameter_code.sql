CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_code
(
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.parameter_code
    IS 'Lookup table containing the fuel indicator codes.';

COMMENT ON COLUMN camdecmpsmd.parameter_code.parameter_cd
    IS 'Unique code for the fuel indicator.';

COMMENT ON COLUMN camdecmpsmd.parameter_code.parameter_cd_description
    IS 'Full description of the indicator code.';