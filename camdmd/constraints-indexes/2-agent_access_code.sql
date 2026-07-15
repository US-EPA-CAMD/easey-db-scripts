ALTER TABLE camdmd.agent_access_code
        ADD CONSTRAINT agent_access_code_r01 FOREIGN KEY (relation_type_cd) 
            REFERENCES camdmd.relation_type_code (relation_type_cd);

CREATE UNIQUE INDEX IF NOT EXISTS agent_access_code_pk 
  ON camdmd.agent_access_code (relation_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS agent_access_code_u01 
  ON camdmd.agent_access_code (ecmps_access_level,ecmps_access_type);