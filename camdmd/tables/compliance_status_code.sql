CREATE TABLE IF NOT EXISTS camdmd.compliance_status_code
(
    comp_status_cd varchar(7) NOT NULL,
    comp_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (comp_status_cd)
);
COMMENT ON TABLE camdmd.compliance_status_code
    IS 'Lookup table for compliance status cd.';
COMMENT ON COLUMN camdmd.compliance_status_code.comp_status_cd
    IS 'Compliance status code.';
COMMENT ON COLUMN camdmd.compliance_status_code.comp_status_description
    IS 'Full description of compliance status.';