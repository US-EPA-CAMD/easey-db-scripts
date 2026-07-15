ALTER TABLE camd.program_phase
        ADD CONSTRAINT fk_program_phase_program FOREIGN KEY (prg_id) 
            REFERENCES camd.program (prg_id);

CREATE INDEX IF NOT EXISTS idx_program_phase_phase 
  ON camd.program_phase (phase);
CREATE INDEX IF NOT EXISTS idx_program_phase_program 
  ON camd.program_phase (prg_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_program_phase 
  ON camd.program_phase (program_phase_id);