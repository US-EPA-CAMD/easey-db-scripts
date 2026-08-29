ALTER TABLE camd.cdx_user_org
        ADD CONSTRAINT fk_cdx_user_org_org_id FOREIGN KEY (cdx_org_id) 
            REFERENCES camd.cdx_org (cdx_org_id);
ALTER TABLE camd.cdx_user_org
        ADD CONSTRAINT fk_cdx_user_org_user_id FOREIGN KEY (cdx_user_id) 
            REFERENCES camd.cdx_user (cdx_user_id);

CREATE INDEX IF NOT EXISTS idx_cdx_user_org_org_id 
  ON camd.cdx_user_org (cdx_org_id);
CREATE INDEX IF NOT EXISTS idx_cdx_user_org_user_id 
  ON camd.cdx_user_org (cdx_user_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cdx_user_org_id 
  ON camd.cdx_user_org (cdx_user_org_id);