CREATE TABLE IF NOT EXISTS camdmd.limit_type_code
(
    limit_type_cd varchar(7) NOT NULL,
    limit_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (limit_type_cd)
);
COMMENT ON TABLE camdmd.limit_type_code
    IS 'Lookup table for limit type cd.';
COMMENT ON COLUMN camdmd.limit_type_code.limit_type_cd
    IS 'Authority limit type code.';
COMMENT ON COLUMN camdmd.limit_type_code.limit_type_description
    IS 'Full description of authority limit type code.';