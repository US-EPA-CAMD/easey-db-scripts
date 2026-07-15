CREATE UNIQUE INDEX IF NOT EXISTS auction_bid_ws_pk 
  ON camdws.auction_bid_ws (auction_bid_ws_id);

ALTER TABLE camdws.auction_bid_ws
        ADD CONSTRAINT fk_auction_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id);