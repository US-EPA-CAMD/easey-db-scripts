ALTER TABLE camd.cdx_user_org_role
        ADD CONSTRAINT fk_cdx_role_id FOREIGN KEY (cdx_role_id) 
            REFERENCES camd.cdx_role (cdx_role_id);
ALTER TABLE camd.cdx_user_org_role
        ADD CONSTRAINT fk_cdx_user_org_id FOREIGN KEY (cdx_user_org_id) 
            REFERENCES camd.cdx_user_org (cdx_user_org_id);

CREATE INDEX IF NOT EXISTS idx_cdx_role_id 
  ON camd.cdx_user_org_role (cdx_role_id);
CREATE INDEX IF NOT EXISTS idx_cdx_user_org_id 
  ON camd.cdx_user_org_role (cdx_user_org_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cdx_user_org_role_id 
  ON camd.cdx_user_org_role (cdx_user_org_role_id);