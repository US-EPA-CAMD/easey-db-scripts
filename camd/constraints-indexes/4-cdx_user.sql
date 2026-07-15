ALTER TABLE camd.cdx_user
        ADD CONSTRAINT fk_cdx_user_ppl_id FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);

CREATE INDEX IF NOT EXISTS idx_cdx_user_ppl_id 
  ON camd.cdx_user (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cdx_user_id 
  ON camd.cdx_user (cdx_user_id);