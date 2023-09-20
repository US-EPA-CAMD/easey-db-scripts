CREATE TABLE IF NOT EXISTS camdecmpsmd.test_claim_code
(
    test_claim_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_claim_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.test_claim_code
    IS 'Lookup table for test claim codes.';

COMMENT ON COLUMN camdecmpsmd.test_claim_code.test_claim_cd
    IS 'Code used to indicate the type of test claim (i.e., single load, normal load exemption or operating range exemption). ';

COMMENT ON COLUMN camdecmpsmd.test_claim_code.test_claim_cd_description
    IS 'Description of lookup code. ';