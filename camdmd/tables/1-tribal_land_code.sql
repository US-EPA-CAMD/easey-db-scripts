-- Table: camdmd.tribal_land_code

-- DROP TABLE camdmd.tribal_land_code;

CREATE TABLE IF NOT EXISTS camdmd.tribal_land_code
(
    tribal_land_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    tribal_land_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tribal_land_code_pk PRIMARY KEY (tribal_land_cd),
    CONSTRAINT tribal_land_code_desc_uq UNIQUE (tribal_land_description)
);

COMMENT ON TABLE camdmd.tribal_land_code
    IS 'Lookup table containing codes for tribal lands.';

COMMENT ON COLUMN camdmd.tribal_land_code.tribal_land_cd
    IS 'The code that indicates the tribal land.';

COMMENT ON COLUMN camdmd.tribal_land_code.tribal_land_description
    IS 'The description of the tribal land.';