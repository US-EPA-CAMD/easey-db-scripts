ALTER TABLE camd.cdx_session
        ADD CONSTRAINT fk_cdx_session_cdx_user FOREIGN KEY (cdx_user_id) 
            REFERENCES camd.cdx_user (cdx_user_id);

CREATE INDEX IF NOT EXISTS idx_cdx_session_cdx_user_id 
  ON camd.cdx_session (cdx_user_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cdx_session_id 
  ON camd.cdx_session (cdx_session_id);