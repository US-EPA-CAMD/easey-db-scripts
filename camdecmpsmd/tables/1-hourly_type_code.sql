-- Table: camdecmpsmd.hourly_type_code

-- DROP TABLE IF EXISTS camdecmpsmd.hourly_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.hourly_type_code
(
    hourly_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    hourly_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_hourly_type_code PRIMARY KEY (hourly_type_cd)
);

COMMENT ON TABLE camdecmpsmd.hourly_type_code
    IS 'Lookup table for hourly type.';

COMMENT ON COLUMN camdecmpsmd.hourly_type_code.hourly_type_cd
    IS 'Code used to identify the hourly type (Monitored vs Derived).';

COMMENT ON COLUMN camdecmpsmd.hourly_type_code.hourly_type_description
    IS 'Description of lookup code.';