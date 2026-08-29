CREATE TABLE IF NOT EXISTS camdmd.security_group_code
(
    security_group_cd varchar(7) NOT NULL,
    security_group_description varchar(1000) NOT NULL,
    PRIMARY KEY (security_group_cd)
);
COMMENT ON TABLE camdmd.security_group_code
    IS 'Lookup table containing codes that indicate the access group for users.';
COMMENT ON COLUMN camdmd.security_group_code.security_group_cd
    IS 'Indicates a user''s access group.';
COMMENT ON COLUMN camdmd.security_group_code.security_group_description
    IS 'The description of the access group.';