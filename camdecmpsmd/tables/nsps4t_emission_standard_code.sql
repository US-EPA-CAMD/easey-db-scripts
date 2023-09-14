CREATE TABLE IF NOT EXISTS camdecmpsmd.nsps4t_emission_standard_code
(
    emission_standard_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    emission_standard_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    emission_standard_uom_cd character varying(7) COLLATE pg_catalog."default",
    emission_standard_load_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.nsps4t_emission_standard_code
    IS 'NSPS4T (quarterly) Summary Information. ';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_cd
    IS 'Code used to identify the NSPS4T Emission Standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_description
    IS 'Description of the NSPS4T Emission Standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_uom_cd
    IS 'Contains the unit of measure for the standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_load_cd
    IS 'Contains the type of electrical load for the standard.';
