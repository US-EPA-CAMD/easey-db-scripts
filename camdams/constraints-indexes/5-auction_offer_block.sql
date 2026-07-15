CREATE INDEX IF NOT EXISTS idx_auction_offer_block_prg_id 
  ON camdams.auction_offer_block (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_auction_offer_block 
  ON camdams.auction_offer_block (auction_offer_block_id);

ALTER TABLE camdams.auction_offer_block
        ADD CONSTRAINT refauction_offer128 FOREIGN KEY (auction_offer_id) 
            REFERENCES camdams.auction_offer (auction_offer_id);
ALTER TABLE camdams.auction_offer_block
        ADD CONSTRAINT refprogram_vintage129 FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);