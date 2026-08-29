CREATE TABLE IF NOT EXISTS camdams.auction_distribution
(
    auction_dist_id numeric(38,0) NOT NULL,
    dist_amount numeric(15,2) NOT NULL,
    fmd_trans_date timestamp without time zone,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    auction_id numeric(38,0) NOT NULL,
    PRIMARY KEY (auction_dist_id)
);
COMMENT ON TABLE camdams.auction_distribution
    IS 'Identifies distribution information for each auction.';
COMMENT ON COLUMN camdams.auction_distribution.auction_dist_id
    IS 'Identity key of auction distribution table.';
COMMENT ON COLUMN camdams.auction_distribution.dist_amount
    IS 'Total proceeds.';
COMMENT ON COLUMN camdams.auction_distribution.fmd_trans_date
    IS 'Date of FMD transactions.';
COMMENT ON COLUMN camdams.auction_distribution.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.auction_distribution.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.auction_distribution.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.auction_distribution.auction_id
    IS 'Identity key for auction table.';