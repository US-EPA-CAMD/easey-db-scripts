CREATE INDEX IF NOT EXISTS idx_unit_generator_ws_ws 
  ON camdws.unit_generator_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_generator_ws 
  ON camdws.unit_generator_ws (unit_gen_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_generator_ws_key 
  ON camdws.unit_generator_ws (unit_gen_id,workspace_session_id);

ALTER TABLE camdws.unit_generator_ws
        ADD CONSTRAINT fk_unit_generator_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;