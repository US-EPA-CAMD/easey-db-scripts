-- Table: camdecmpsmd.fuel_indicator_code

-- DROP TABLE camdecmpsmd.fuel_indicator_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_indicator_code
(
    fuel_indicator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_indicator_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_fuel_indicator_code PRIMARY KEY (fuel_indicator_cd),
    CONSTRAINT uq_fuel_indicator_code_desc UNIQUE (fuel_indicator_description)
);

COMMENT ON TABLE camdecmpsmd.fuel_indicator_code
    IS 'Lookup table containing the fuel indicator codes.';

COMMENT ON COLUMN camdecmpsmd.fuel_indicator_code.fuel_indicator_cd
    IS 'Unique code for the fuel indicator.';

COMMENT ON COLUMN camdecmpsmd.fuel_indicator_code.fuel_indicator_description
    IS 'Full description of the indicator code.';