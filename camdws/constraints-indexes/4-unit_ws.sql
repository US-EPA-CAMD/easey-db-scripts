CREATE INDEX IF NOT EXISTS idx_unit_naics 
  ON camdws.unit_ws (naics_cd);
CREATE INDEX IF NOT EXISTS idx_unit_source_category 
  ON camdws.unit_ws (source_category_cd);
CREATE INDEX IF NOT EXISTS idx_unit_ws_plant 
  ON camdws.unit_ws (workspace_session_id,fac_id);
CREATE INDEX IF NOT EXISTS idx_unit_ws_ws 
  ON camdws.unit_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_ws 
  ON camdws.unit_ws (unit_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_ws_key 
  ON camdws.unit_ws (workspace_session_id,unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_ws_log 
  ON camdws.unit_ws (workspace_session_id,fac_id,unitid);

ALTER TABLE camdws.unit_ws
        ADD CONSTRAINT fk_unit_ws_naics FOREIGN KEY (naics_cd) 
            REFERENCES camdmd.naics_code (naics_cd);
ALTER TABLE camdws.unit_ws
        ADD CONSTRAINT fk_unit_ws_plant FOREIGN KEY (fac_id, workspace_session_id) 
            REFERENCES camdws.plant_ws (fac_id, workspace_session_id);
ALTER TABLE camdws.unit_ws
        ADD CONSTRAINT fk_unit_ws_source_category FOREIGN KEY (source_category_cd) 
            REFERENCES camdmd.source_category_code (source_category_cd);
ALTER TABLE camdws.unit_ws
        ADD CONSTRAINT fk_unit_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;