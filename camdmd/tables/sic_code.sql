CREATE TABLE IF NOT EXISTS camdmd.sic_code
(
    sic_code numeric(4,0) NOT NULL,
    sic_code_description character varying(50) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdmd.sic_code
    IS 'Standard Industrial Classification System identification number, on a FACILITY basis.';

COMMENT ON COLUMN camdmd.sic_code.sic_code
    IS 'Standard Industrial Classification System identification number, on a FACILITY basis.';

COMMENT ON COLUMN camdmd.sic_code.sic_code_description
    IS 'Description of SIC Code.';
