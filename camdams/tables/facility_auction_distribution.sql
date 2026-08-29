CREATE TABLE IF NOT EXISTS camdams.facility_auction_distribution
(
    fac_auction_dist_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    auction_dist_id numeric(38,0) NOT NULL,
    auction_payee_id numeric(38,0) NOT NULL,
    dist_amount numeric(15,2) NOT NULL,
    exempt_amount numeric(15,2) NOT NULL,
    ppl_id numeric(38,0) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    PRIMARY KEY (fac_auction_dist_id)
);
COMMENT ON TABLE camdams.facility_auction_distribution
    IS 'Links facility and auction payee to the auction distribution information.';
COMMENT ON COLUMN camdams.facility_auction_distribution.fac_auction_dist_id
    IS 'Identity key for facility auction distribution table.';
COMMENT ON COLUMN camdams.facility_auction_distribution.fac_id
    IS 'Identity key for facility table.';
COMMENT ON COLUMN camdams.facility_auction_distribution.auction_dist_id
    IS 'Identity key for auction distribution table.';
COMMENT ON COLUMN camdams.facility_auction_distribution.auction_payee_id
    IS 'Identity key for auction payee table.';
COMMENT ON COLUMN camdams.facility_auction_distribution.dist_amount
    IS 'Proceeds allocated to the facility for the auction.';
COMMENT ON COLUMN camdams.facility_auction_distribution.exempt_amount
    IS 'Exempt proceeds allocated to the facility for the auction.';
COMMENT ON COLUMN camdams.facility_auction_distribution.ppl_id
    IS 'Identity key for people table.';
COMMENT ON COLUMN camdams.facility_auction_distribution.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.facility_auction_distribution.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.facility_auction_distribution.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';