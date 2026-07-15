CREATE INDEX IF NOT EXISTS idx_program_vintage_prg 
  ON camdams.program_vintage (prg_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_program_vintage 
  ON camdams.program_vintage (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq1_program_vintage_prg_begin 
  ON camdams.program_vintage (prg_cd,begin_date);
CREATE UNIQUE INDEX IF NOT EXISTS uq2_program_vintage_prg_year 
  ON camdams.program_vintage (prg_cd,vintage_year);

ALTER TABLE camdams.program_vintage
        ADD CONSTRAINT fk_program_vintage_prg FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);