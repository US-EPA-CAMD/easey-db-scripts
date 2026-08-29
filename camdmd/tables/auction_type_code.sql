CREATE TABLE IF NOT EXISTS camdmd.auction_type_code
(
    auction_type_cd varchar(7) NOT NULL,
    auction_type_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (auction_type_cd)
);
COMMENT ON TABLE camdmd.auction_type_code
    IS 'Lookup table for auction type cd.';
COMMENT ON COLUMN camdmd.auction_type_code.auction_type_cd
    IS 'Indicates the type of auction.';
COMMENT ON COLUMN camdmd.auction_type_code.auction_type_cd_description
    IS 'Full description of auction type.';