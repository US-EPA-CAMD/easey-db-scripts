-- Table: camdmd.epa_region_code

-- DROP TABLE camdmd.epa_region_code;

CREATE TABLE camdmd.epa_region_code
(
    epa_region_cd numeric(2,0) NOT NULL,
    epa_region_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_epa_region_code PRIMARY KEY (epa_region_cd),
    CONSTRAINT uq_epa_region_desc UNIQUE (epa_region_description)
);

COMMENT ON TABLE camdmd.epa_region_code
    IS 'List of EPA regions and descriptions.';

COMMENT ON COLUMN camdmd.epa_region_code.epa_region_cd
    IS 'The EPA Region in which a FACILITY is located.';

COMMENT ON COLUMN camdmd.epa_region_code.epa_region_description
    IS 'Description of EPA REGION code.';