CREATE TABLE IF NOT EXISTS camdmd.allowance_type_code
(
    allow_type_cd varchar(7) NOT NULL,
    allow_type_description varchar(1000) NOT NULL,
    allow_type_display varchar(1000),
    PRIMARY KEY (allow_type_cd)
);
COMMENT ON TABLE camdmd.allowance_type_code
    IS 'Lookup table for allowance type cd.';
COMMENT ON COLUMN camdmd.allowance_type_code.allow_type_cd
    IS 'Type of allowance.';
COMMENT ON COLUMN camdmd.allowance_type_code.allow_type_description
    IS 'Full description of type of allowance.';
COMMENT ON COLUMN camdmd.allowance_type_code.allow_type_display
    IS 'On screen display for allowance type.';