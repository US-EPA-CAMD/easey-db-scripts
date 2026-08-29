CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_ws_unit 
  ON camdws.unit_boiler_type_ws (unit_id);
CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_ws_ws 
  ON camdws.unit_boiler_type_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_boiler_type_ws 
  ON camdws.unit_boiler_type_ws (unit_boiler_type_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_boiler_type_ws_key 
  ON camdws.unit_boiler_type_ws (unit_boiler_type_id,workspace_session_id);

ALTER TABLE camdws.unit_boiler_type_ws
        ADD CONSTRAINT fk_unit_boiler_type_ws_u_type FOREIGN KEY (unit_type_cd) 
            REFERENCES camdmd.unit_type_code (unit_type_cd);
ALTER TABLE camdws.unit_boiler_type_ws
        ADD CONSTRAINT fk_unit_boiler_type_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;