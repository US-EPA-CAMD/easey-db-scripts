CREATE TABLE IF NOT EXISTS camdmd.approval_code
(
    approval_cd varchar(7) NOT NULL,
    approval_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (approval_cd)
);
COMMENT ON TABLE camdmd.approval_code
    IS 'Lookup table for emissions approval codes. ';
COMMENT ON COLUMN camdmd.approval_code.approval_cd
    IS 'Emissions approval code.';
COMMENT ON COLUMN camdmd.approval_code.approval_cd_description
    IS 'Full description of emissions approval code.';