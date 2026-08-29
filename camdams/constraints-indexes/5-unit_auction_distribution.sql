CREATE INDEX IF NOT EXISTS idx_unit_auct_dist_auctdistid 
  ON camdams.unit_auction_distribution (auction_dist_id);
CREATE INDEX IF NOT EXISTS idx_unit_auct_dist_unit_id 
  ON camdams.unit_auction_distribution (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_auction_dist 
  ON camdams.unit_auction_distribution (unit_auction_dist_id);

ALTER TABLE camdams.unit_auction_distribution
        ADD CONSTRAINT fk_unit_auct_dist_auct_dist FOREIGN KEY (auction_dist_id) 
            REFERENCES camdams.auction_distribution (auction_dist_id);
ALTER TABLE camdams.unit_auction_distribution
        ADD CONSTRAINT fk_unit_auct_dist_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);