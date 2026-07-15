CREATE INDEX IF NOT EXISTS idx_auction_auction_year 
  ON camdams.auction (auction_year);
CREATE INDEX IF NOT EXISTS idx_auction_auct_type_cd 
  ON camdams.auction (auction_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction 
  ON camdams.auction (auction_id);

ALTER TABLE camdams.auction
        ADD CONSTRAINT refauction_type_code120 FOREIGN KEY (auction_type_cd) 
            REFERENCES camdmd.auction_type_code (auction_type_cd);