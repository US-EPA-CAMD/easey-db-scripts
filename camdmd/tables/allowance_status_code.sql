CREATE TABLE IF NOT EXISTS camdmd.allowance_status_code
(
    allow_status_cd varchar(7) NOT NULL,
    allow_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (allow_status_cd)
);
COMMENT ON TABLE camdmd.allowance_status_code
    IS 'Lookup table for allowance status cd.';
COMMENT ON COLUMN camdmd.allowance_status_code.allow_status_cd
    IS 'Allowance status code.';
COMMENT ON COLUMN camdmd.allowance_status_code.allow_status_description
    IS 'Allowance status description.';