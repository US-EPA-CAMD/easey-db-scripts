CREATE INDEX IF NOT EXISTS idx_auction_bid_acct_id 
  ON camdams.auction_bid (account_id);
CREATE INDEX IF NOT EXISTS idx_auction_bid_auct_id 
  ON camdams.auction_bid (auction_id);
CREATE INDEX IF NOT EXISTS idx_auction_bid_pay_meth_cd 
  ON camdams.auction_bid (payment_method_cd);
CREATE INDEX IF NOT EXISTS idx_auction_bid_ppl_id 
  ON camdams.auction_bid (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction_bid 
  ON camdams.auction_bid (auction_bid_id);

ALTER TABLE camdams.auction_bid
        ADD CONSTRAINT fk_bid_status_code FOREIGN KEY (bid_status_cd) 
            REFERENCES camdmd.bid_status_code (bid_status_cd);
ALTER TABLE camdams.auction_bid
        ADD CONSTRAINT refaccount122 FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.auction_bid
        ADD CONSTRAINT refauction121 FOREIGN KEY (auction_id) 
            REFERENCES camdams.auction (auction_id);
ALTER TABLE camdams.auction_bid
        ADD CONSTRAINT refpayment_method_code124 FOREIGN KEY (payment_method_cd) 
            REFERENCES camdmd.payment_method_code (payment_method_cd);
ALTER TABLE camdams.auction_bid
        ADD CONSTRAINT refpeople123 FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);