CREATE TABLE IF NOT EXISTS camdmd.bid_status_code
(
    bid_status_cd varchar(8) NOT NULL,
    bid_status_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (bid_status_cd)
);
COMMENT ON TABLE camdmd.bid_status_code
    IS 'Lookup table for Bid status code.';
COMMENT ON COLUMN camdmd.bid_status_code.bid_status_cd
    IS 'Bid status code.';
COMMENT ON COLUMN camdmd.bid_status_code.bid_status_cd_description
    IS 'Bis status description.';