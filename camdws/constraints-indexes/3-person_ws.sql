CREATE INDEX IF NOT EXISTS idx_person_ws_agency 
  ON camdws.person_ws (agency_id,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_person_ws_company_ws 
  ON camdws.person_ws (company_id,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_person_ws_person_type 
  ON camdws.person_ws (workspace_session_id,person_type_cd);
CREATE INDEX IF NOT EXISTS idx_person_ws_security_group 
  ON camdws.person_ws (workspace_session_id,security_group_cd);
CREATE INDEX IF NOT EXISTS idx_person_ws_workspace 
  ON camdws.person_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_person_ws 
  ON camdws.person_ws (person_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_person_ws 
  ON camdws.person_ws (ppl_id,workspace_session_id);

ALTER TABLE camdws.person_ws
        ADD CONSTRAINT fk_person_ws_agency FOREIGN KEY (agency_id) 
            REFERENCES camd.agency (agency_id);
ALTER TABLE camdws.person_ws
        ADD CONSTRAINT fk_person_ws_company_ws FOREIGN KEY (company_id, workspace_session_id) 
            REFERENCES camdws.company_ws (company_id, workspace_session_id);
ALTER TABLE camdws.person_ws
        ADD CONSTRAINT fk_person_ws_person_type FOREIGN KEY (person_type_cd) 
            REFERENCES camdmd.person_type_code (person_type_cd);
ALTER TABLE camdws.person_ws
        ADD CONSTRAINT fk_person_ws_security_group FOREIGN KEY (security_group_cd) 
            REFERENCES camdmd.security_group_code (security_group_cd);
ALTER TABLE camdws.person_ws
        ADD CONSTRAINT fk_person_ws_workspace FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;