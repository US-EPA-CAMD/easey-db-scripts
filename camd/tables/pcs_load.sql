CREATE TABLE IF NOT EXISTS camd.pcs_load
(
    ppl_id numeric NOT NULL,
    cert_id numeric(2,0) NOT NULL
);
COMMENT ON TABLE camd.pcs_load
    IS 'Temporary PERSON_CERT_STATEMENT table used to the load the legacy data. Copy of Legacy CAMD.PEOPLE_CERT_STATEMENT table.';
COMMENT ON COLUMN camd.pcs_load.ppl_id
    IS 'ID of the person in the PERSON table.';
COMMENT ON COLUMN camd.pcs_load.cert_id
    IS 'ID of the cert statement in the CERT_STATEMENT table.';