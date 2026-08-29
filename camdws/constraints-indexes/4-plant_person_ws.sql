CREATE INDEX IF NOT EXISTS idx_plant_person_ws_lk 
  ON camdws.plant_person_ws (<td>);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_person_grp 
  ON camdws.plant_person_ws (person_type_group_cd,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_person_ws 
  ON camdws.plant_person_ws (ppl_id,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_plant_ws 
  ON camdws.plant_person_ws (fac_id,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_program 
  ON camdws.plant_person_ws (prg_cd,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_responsib 
  ON camdws.plant_person_ws (responsibility_id,workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_unit_id 
  ON camdws.plant_person_ws (fac_id,ppl_id,end_date);
CREATE INDEX IF NOT EXISTS idx_plant_person_ws_workspace 
  ON camdws.plant_person_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_person_ws 
  ON camdws.plant_person_ws (plant_person_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_person_ws 
  ON camdws.plant_person_ws (fac_ppl_id,workspace_session_id);

ALTER TABLE camdws.plant_person_ws
        ADD CONSTRAINT fk_plant_person_ws_person_grp FOREIGN KEY (person_type_group_cd) 
            REFERENCES camdmd.person_type_group_code (person_type_group_cd);
ALTER TABLE camdws.plant_person_ws
        ADD CONSTRAINT fk_plant_person_ws_person_ws FOREIGN KEY (ppl_id, workspace_session_id) 
            REFERENCES camdws.person_ws (ppl_id, workspace_session_id);
ALTER TABLE camdws.plant_person_ws
        ADD CONSTRAINT fk_plant_person_ws_program FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camdws.plant_person_ws
        ADD CONSTRAINT fk_plant_person_ws_responsib FOREIGN KEY (responsibility_id) 
            REFERENCES camdmd.responsibility (responsibility_id);
ALTER TABLE camdws.plant_person_ws
        ADD CONSTRAINT fk_plant_person_ws_workspace FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;