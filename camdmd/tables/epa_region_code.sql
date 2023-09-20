CREATE TABLE IF NOT EXISTS camdmd.epa_region_code
(
    epa_region_cd numeric(2,0) NOT NULL,
    epa_region_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdmd.epa_region_code
    IS 'List of EPA regions and descriptions.';

COMMENT ON COLUMN camdmd.epa_region_code.epa_region_cd
    IS 'The EPA Region in which a FACILITY is located.';

COMMENT ON COLUMN camdmd.epa_region_code.epa_region_description
    IS 'Description of EPA REGION code.';
