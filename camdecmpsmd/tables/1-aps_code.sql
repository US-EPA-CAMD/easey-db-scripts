-- Table: camdecmpsmd.aps_code

-- DROP TABLE camdecmpsmd.aps_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.aps_code
(
    aps_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    aps_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_aps_code PRIMARY KEY (aps_cd)
);

COMMENT ON TABLE camdecmpsmd.aps_code
    IS 'Lookup table for alternate performance specification';

COMMENT ON COLUMN camdecmpsmd.aps_code.aps_cd
    IS ' Code used to identify the alternate performance specification.';

COMMENT ON COLUMN camdecmpsmd.aps_code.aps_description
    IS ' Description of alternate performance specification code.';