ALTER TABLE camd.program
        ADD CONSTRAINT fk_program_code FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camd.program
        ADD CONSTRAINT fk_program_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camd.program
        ADD CONSTRAINT fk_program_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);

CREATE INDEX IF NOT EXISTS idx_program_code 
  ON camd.program (prg_cd);
CREATE INDEX IF NOT EXISTS idx_program_state 
  ON camd.program (state_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_program 
  ON camd.program (prg_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_program_code_state 
  ON camd.program (prg_cd,state_cd);