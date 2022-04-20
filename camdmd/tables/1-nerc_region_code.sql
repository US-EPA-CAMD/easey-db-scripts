-- Table: camdmd.nerc_region_code

-- DROP TABLE camdmd.nerc_region_code;

CREATE TABLE camdmd.nerc_region_code
(
    nerc_region_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    nerc_region_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_nerc_region PRIMARY KEY (nerc_region_cd)
);

COMMENT ON TABLE camdmd.nerc_region_code
    IS 'Facility location, under one of thirteen regions as specified by the  North American Electric Reliability Council.';

COMMENT ON COLUMN camdmd.nerc_region_code.nerc_region_cd
    IS 'Code for one of thirteen regions as specified by the  North American Electric Reliability Council.';

COMMENT ON COLUMN camdmd.nerc_region_code.nerc_region_description
    IS 'One of the thirteen regions in the North American Electric Reliability Council.';