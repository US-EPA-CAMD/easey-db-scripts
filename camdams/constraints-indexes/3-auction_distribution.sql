CREATE INDEX IF NOT EXISTS idx_auction_distrib_auction_id 
  ON camdams.auction_distribution (auction_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction_dist 
  ON camdams.auction_distribution (auction_dist_id);

ALTER TABLE camdams.auction_distribution
        ADD CONSTRAINT fk_auct_dist_auct FOREIGN KEY (auction_id) 
            REFERENCES camdams.auction (auction_id);