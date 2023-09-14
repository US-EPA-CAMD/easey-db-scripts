CREATE TABLE IF NOT EXISTS camdecmpsmd.gas_level_code
(
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    gas_level_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    cal_category character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.gas_level_code
    IS 'Lookup table of calibration gas level codes.';

COMMENT ON COLUMN camdecmpsmd.gas_level_code.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmpsmd.gas_level_code.gas_level_description
    IS 'Description of a gas level code. ';

COMMENT ON COLUMN camdecmpsmd.gas_level_code.cal_category
    IS 'Identifies the entities for which a gas level code is applicable. ';