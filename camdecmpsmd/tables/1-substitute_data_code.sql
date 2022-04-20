-- Table: camdecmpsmd.substitute_data_code

-- DROP TABLE camdecmpsmd.substitute_data_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.substitute_data_code
(
    sub_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sub_data_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_substitute_data_code PRIMARY KEY (sub_data_cd)
);

COMMENT ON TABLE camdecmpsmd.substitute_data_code
    IS 'Lookup table of missing data approach for methodology.   Record Type 585.';

COMMENT ON COLUMN camdecmpsmd.substitute_data_code.sub_data_cd
    IS 'Code used to identify the substitute data approach type. ';

COMMENT ON COLUMN camdecmpsmd.substitute_data_code.sub_data_cd_description
    IS 'Description of lookup code. ';