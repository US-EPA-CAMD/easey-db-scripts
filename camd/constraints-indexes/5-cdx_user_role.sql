ALTER TABLE camd.cdx_user_role
        ADD CONSTRAINT fk_cdx_user_role_role_id FOREIGN KEY (cdx_role_id) 
            REFERENCES camd.cdx_role (cdx_role_id);
ALTER TABLE camd.cdx_user_role
        ADD CONSTRAINT fk_cdx_user_role_user_id FOREIGN KEY (cdx_user_id) 
            REFERENCES camd.cdx_user (cdx_user_id);

CREATE INDEX IF NOT EXISTS idx_cdx_cdx_user_role_id 
  ON camd.cdx_user_role (cdx_role_id);
CREATE INDEX IF NOT EXISTS idx_cdx_cdx_user_user_id 
  ON camd.cdx_user_role (cdx_user_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cdx_user_role_id 
  ON camd.cdx_user_role (cdx_user_role_id);