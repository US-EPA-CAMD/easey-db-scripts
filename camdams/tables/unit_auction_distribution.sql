CREATE TABLE IF NOT EXISTS camdams.unit_auction_distribution
(
    unit_auction_dist_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    auction_dist_id numeric(38,0) NOT NULL,
    dist_amount numeric(15,2) NOT NULL,
    exempt_amount numeric(15,2) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    PRIMARY KEY (unit_auction_dist_id)
);
COMMENT ON TABLE camdams.unit_auction_distribution
    IS 'Links unit and auction payee to the auction distribution information.';
COMMENT ON COLUMN camdams.unit_auction_distribution.unit_auction_dist_id
    IS 'Identity key for unit action distribution table.';
COMMENT ON COLUMN camdams.unit_auction_distribution.unit_id
    IS 'Identity key for unit table.';
COMMENT ON COLUMN camdams.unit_auction_distribution.auction_dist_id
    IS 'Identity key for auction distribution table.';
COMMENT ON COLUMN camdams.unit_auction_distribution.dist_amount
    IS 'Proceeds allocated to the unit for the auction.';
COMMENT ON COLUMN camdams.unit_auction_distribution.exempt_amount
    IS 'Exempt proceeds allocated to the unit for the auction.';
COMMENT ON COLUMN camdams.unit_auction_distribution.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.unit_auction_distribution.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.unit_auction_distribution.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';