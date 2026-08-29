CREATE INDEX IF NOT EXISTS idx_facl_auct_dist_auctdistid 
  ON camdams.facility_auction_distribution (auction_dist_id);
CREATE INDEX IF NOT EXISTS idx_facl_auct_dist_auctpayid 
  ON camdams.facility_auction_distribution (auction_payee_id);
CREATE INDEX IF NOT EXISTS idx_facl_auct_dist_fac_id 
  ON camdams.facility_auction_distribution (fac_id);
CREATE INDEX IF NOT EXISTS idx_facl_auct_dist_ppl_id 
  ON camdams.facility_auction_distribution (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_facility_auction_dist 
  ON camdams.facility_auction_distribution (fac_auction_dist_id);

ALTER TABLE camdams.facility_auction_distribution
        ADD CONSTRAINT fk_fac_auct_dist_auct_dist FOREIGN KEY (auction_dist_id) 
            REFERENCES camdams.auction_distribution (auction_dist_id);
ALTER TABLE camdams.facility_auction_distribution
        ADD CONSTRAINT fk_fac_auct_dist_auct_payee FOREIGN KEY (auction_payee_id) 
            REFERENCES camdams.auction_payee (auction_payee_id);
ALTER TABLE camdams.facility_auction_distribution
        ADD CONSTRAINT fk_fac_auct_dist_fac FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdams.facility_auction_distribution
        ADD CONSTRAINT fk_fac_auct_dist_ppl FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);