-- Table: camdecmpsmd.qual_type_code

-- DROP TABLE camdecmpsmd.qual_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.qual_type_code
(
    qual_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qual_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    qual_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'PCT'::character varying,
    CONSTRAINT pk_qual_type_code PRIMARY KEY (qual_type_cd)
);

COMMENT ON TABLE camdecmpsmd.qual_type_code
    IS 'Lookup table for type of special monitoring or testing exemption/qualification.';

COMMENT ON COLUMN camdecmpsmd.qual_type_code.qual_type_cd
    IS 'Code used to identify the qualification type. ';

COMMENT ON COLUMN camdecmpsmd.qual_type_code.qual_type_cd_description
    IS 'Description of lookup code. ';