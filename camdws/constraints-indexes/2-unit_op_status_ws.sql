CREATE INDEX IF NOT EXISTS idx_unit_op_status_ws_code 
  ON camdws.unit_op_status_ws (op_status_cd);
CREATE INDEX IF NOT EXISTS idx_unit_op_status_ws_ws 
  ON camdws.unit_op_status_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_op_status_ws 
  ON camdws.unit_op_status_ws (unit_op_status_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_op_status_ws_key 
  ON camdws.unit_op_status_ws (unit_op_status_id,workspace_session_id);

ALTER TABLE camdws.unit_op_status_ws
        ADD CONSTRAINT fk_unit_op_status_ws_code FOREIGN KEY (op_status_cd) 
            REFERENCES camdmd.operating_status_code (op_status_cd);
ALTER TABLE camdws.unit_op_status_ws
        ADD CONSTRAINT fk_unit_op_status_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;