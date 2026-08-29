CREATE TABLE IF NOT EXISTS camdmd.distribution_type_code
(
    dist_type_cd varchar(7) NOT NULL,
    dist_type_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (dist_type_cd)
);
COMMENT ON TABLE camdmd.distribution_type_code
    IS 'Lookup table for auction distribution type codes.';
COMMENT ON COLUMN camdmd.distribution_type_code.dist_type_cd
    IS 'Auction distribution type code.';
COMMENT ON COLUMN camdmd.distribution_type_code.dist_type_cd_description
    IS 'Full description of auction distribution type code.';