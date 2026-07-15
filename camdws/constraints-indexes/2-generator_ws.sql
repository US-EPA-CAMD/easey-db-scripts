CREATE INDEX IF NOT EXISTS idx_generator_ws_gen_source 
  ON camdws.generator_ws (gen_source_cd);
CREATE INDEX IF NOT EXISTS idx_generator_ws_prime_mover 
  ON camdws.generator_ws (prime_mover_type_cd);
CREATE INDEX IF NOT EXISTS idx_generator_ws_ws 
  ON camdws.generator_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_generator_ws 
  ON camdws.generator_ws (gen_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_generator_ws_key 
  ON camdws.generator_ws (gen_id,workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_generator_ws_log 
  ON camdws.generator_ws (workspace_session_id,fac_id,genid);

ALTER TABLE camdws.generator_ws
        ADD CONSTRAINT fk_generator_ws_gen_source FOREIGN KEY (gen_source_cd) 
            REFERENCES camdmd.generator_source_code (gen_source_cd);
ALTER TABLE camdws.generator_ws
        ADD CONSTRAINT fk_generator_ws_prime_mover FOREIGN KEY (prime_mover_type_cd) 
            REFERENCES camdmd.prime_mover_type_code (prime_mover_type_cd);
ALTER TABLE camdws.generator_ws
        ADD CONSTRAINT fk_generator_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;