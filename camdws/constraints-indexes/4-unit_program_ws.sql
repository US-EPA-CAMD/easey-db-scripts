CREATE INDEX IF NOT EXISTS idx_unit_program_class 
  ON camdws.unit_program_ws (prg_cd,class_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_ws_applic 
  ON camdws.unit_program_ws (app_status_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_ws_nonstand 
  ON camdws.unit_program_ws (nonstandard_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_ws_ws 
  ON camdws.unit_program_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_program_ws 
  ON camdws.unit_program_ws (up_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_program_ws_key 
  ON camdws.unit_program_ws (up_id,workspace_session_id);

ALTER TABLE camdws.unit_program_ws
        ADD CONSTRAINT fk_unit_program_ws_applic FOREIGN KEY (app_status_cd) 
            REFERENCES camdmd.applicability_status_code (app_status_cd);
ALTER TABLE camdws.unit_program_ws
        ADD CONSTRAINT fk_unit_program_ws_class FOREIGN KEY (prg_cd, class_cd) 
            REFERENCES camdmd.program_class (prg_cd, class_cd);
ALTER TABLE camdws.unit_program_ws
        ADD CONSTRAINT fk_unit_program_ws_nonstand FOREIGN KEY (nonstandard_cd) 
            REFERENCES camdmd.nonstandard_code (nonstandard_cd);
ALTER TABLE camdws.unit_program_ws
        ADD CONSTRAINT fk_unit_program_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;