CREATE INDEX IF NOT EXISTS idx_rep_agent_ws_ag 
  ON camdws.rep_agent_ws (workspace_session_id,agent_id);
CREATE INDEX IF NOT EXISTS idx_rep_agent_ws_pp 
  ON camdws.rep_agent_ws (workspace_session_id,agent_id,rep_id);
CREATE INDEX IF NOT EXISTS idx_rep_agent_ws_re 
  ON camdws.rep_agent_ws (workspace_session_id,rep_id);
CREATE INDEX IF NOT EXISTS idx_rep_agent_ws_t 
  ON camdws.rep_agent_ws (workspace_session_id,relation_type_cd);
CREATE INDEX IF NOT EXISTS idx_rep_agent_ws_ws 
  ON camdws.rep_agent_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_rep_agent_ws 
  ON camdws.rep_agent_ws (id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_rep_agent_ws_key 
  ON camdws.rep_agent_ws (workspace_session_id,rep_agent_id,rep_agent_unit_id);

ALTER TABLE camdws.rep_agent_ws
        ADD CONSTRAINT fk_rep_agent_ws_cnt FOREIGN KEY (agent_id, workspace_session_id) 
            REFERENCES camdws.person_ws (ppl_id, workspace_session_id);
ALTER TABLE camdws.rep_agent_ws
        ADD CONSTRAINT fk_rep_agent_ws_ppl FOREIGN KEY (rep_id, workspace_session_id) 
            REFERENCES camdws.person_ws (ppl_id, workspace_session_id);
ALTER TABLE camdws.rep_agent_ws
        ADD CONSTRAINT fk_rep_agent_ws_typ FOREIGN KEY (relation_type_cd) 
            REFERENCES camdmd.relation_type_code (relation_type_cd);
ALTER TABLE camdws.rep_agent_ws
        ADD CONSTRAINT fk_rep_agent_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;