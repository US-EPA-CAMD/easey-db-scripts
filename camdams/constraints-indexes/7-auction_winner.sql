CREATE INDEX IF NOT EXISTS idx_auct_winner_auctbidid 
  ON camdams.auction_winner (auction_bid_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction_winner 
  ON camdams.auction_winner (auction_winner_id);

ALTER TABLE camdams.auction_winner
        ADD CONSTRAINT fk_auction_win_auction_bid FOREIGN KEY (auction_bid_id) 
            REFERENCES camdams.auction_bid (auction_bid_id);
ALTER TABLE camdams.auction_winner
        ADD CONSTRAINT fk_auction_win_auction_offer FOREIGN KEY (auction_offer_id) 
            REFERENCES camdams.auction_offer (auction_offer_id);
ALTER TABLE camdams.auction_winner
        ADD CONSTRAINT fk_auct_winner_trans FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);