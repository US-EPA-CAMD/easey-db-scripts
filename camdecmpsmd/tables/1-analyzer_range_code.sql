-- Table: camdecmpsmd.analyzer_range_code

-- DROP TABLE camdecmpsmd.analyzer_range_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.analyzer_range_code
(
    analyzer_range_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    analyzer_range_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_analyzer_range_code PRIMARY KEY (analyzer_range_cd)
);

COMMENT ON TABLE camdecmpsmd.analyzer_range_code
    IS 'Lookup table for analyzer range code.';

COMMENT ON COLUMN camdecmpsmd.analyzer_range_code.analyzer_range_cd
    IS 'Code used to identify the analyzer range. ';

COMMENT ON COLUMN camdecmpsmd.analyzer_range_code.analyzer_range_cd_description
    IS 'Description of lookup code. ';