-- Table: camdecmpsmd.operating_condition_code

-- DROP TABLE camdecmpsmd.operating_condition_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.operating_condition_code
(
    operating_condition_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_condition_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_operating_condition_code PRIMARY KEY (operating_condition_cd)
);

COMMENT ON TABLE camdecmpsmd.operating_condition_code
    IS 'Lookup table of Indicator codes.';

COMMENT ON COLUMN camdecmpsmd.operating_condition_code.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmpsmd.operating_condition_code.op_condition_cd_description
    IS 'Description of lookup code. ';