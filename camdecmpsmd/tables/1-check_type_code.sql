-- Table: camdecmpsmd.check_type_code

-- DROP TABLE camdecmpsmd.check_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_type_code
(
    check_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_check_type_code PRIMARY KEY (check_type_cd)
);

COMMENT ON TABLE camdecmpsmd.check_type_code
    IS 'Evaluation check type code.';

COMMENT ON COLUMN camdecmpsmd.check_type_code.check_type_cd
    IS ' Code used to identify the check type.';

COMMENT ON COLUMN camdecmpsmd.check_type_code.check_type_cd_description
    IS ' Description of lookup code.';