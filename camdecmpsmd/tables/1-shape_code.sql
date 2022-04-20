-- Table: camdecmpsmd.shape_code

-- DROP TABLE camdecmpsmd.shape_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.shape_code
(
    shape_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    shape_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_shape_code PRIMARY KEY (shape_cd)
);

COMMENT ON TABLE camdecmpsmd.shape_code
    IS 'Lookup table of shape codes for monitoring locations.';

COMMENT ON COLUMN camdecmpsmd.shape_code.shape_cd
    IS 'Code identifying the shape of a monitor location. ';

COMMENT ON COLUMN camdecmpsmd.shape_code.shape_cd_description
    IS 'Description of lookup code. ';