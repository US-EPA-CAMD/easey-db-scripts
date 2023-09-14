CREATE TABLE IF NOT EXISTS camdecmpsmd.analytical_principle_code
(
    analytical_principle_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    analytical_principle_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);


COMMENT ON TABLE camdecmpsmd.analytical_principle_code
    IS 'Lookup table for analytical principle code.';

COMMENT ON COLUMN camdecmpsmd.analytical_principle_code.analytical_principle_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpsmd.analytical_principle_code.analytical_principle_cd_description
    IS 'Description of lookup code.';
