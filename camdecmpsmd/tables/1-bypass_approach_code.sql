-- Table: camdecmpsmd.bypass_approach_code

-- DROP TABLE camdecmpsmd.bypass_approach_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.bypass_approach_code
(
    bypass_approach_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    bypass_approach_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_bypass_approach_code PRIMARY KEY (bypass_approach_cd)
);

COMMENT ON TABLE camdecmpsmd.bypass_approach_code
    IS 'The value to be used for an unmonitored stack.';

COMMENT ON COLUMN camdecmpsmd.bypass_approach_code.bypass_approach_cd
    IS 'Code used to identify the value to be used for an unmonitored bypass stack. ';

COMMENT ON COLUMN camdecmpsmd.bypass_approach_code.bypass_approach_cd_description
    IS 'Description of lookup code. ';