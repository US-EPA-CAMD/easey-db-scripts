-- Table: camdecmpsmd.units_of_measure_code

-- DROP TABLE camdecmpsmd.units_of_measure_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.units_of_measure_code
(
    uom_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    uom_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_units_of_measure_code PRIMARY KEY (uom_cd)
);

COMMENT ON TABLE camdecmpsmd.units_of_measure_code
    IS 'Lookup table of units of measure.';

COMMENT ON COLUMN camdecmpsmd.units_of_measure_code.uom_cd
    IS 'Code used to identify the units of measure. ';

COMMENT ON COLUMN camdecmpsmd.units_of_measure_code.uom_cd_description
    IS 'Description of lookup code. ';