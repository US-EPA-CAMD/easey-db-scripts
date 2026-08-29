CREATE INDEX IF NOT EXISTS idx_auction_offer_acct_id 
  ON camdams.auction_offer (account_id);
CREATE INDEX IF NOT EXISTS idx_auction_offer_auct_id 
  ON camdams.auction_offer (auction_id);
CREATE INDEX IF NOT EXISTS idx_auction_offer_ppl_id 
  ON camdams.auction_offer (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction_offer 
  ON camdams.auction_offer (auction_offer_id);

ALTER TABLE camdams.auction_offer
        ADD CONSTRAINT refaccount126 FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.auction_offer
        ADD CONSTRAINT refauction125 FOREIGN KEY (auction_id) 
            REFERENCES camdams.auction (auction_id);
ALTER TABLE camdams.auction_offer
        ADD CONSTRAINT refpeople127 FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);