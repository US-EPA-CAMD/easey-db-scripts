ALTER TABLE camd.unit_program
        ADD CONSTRAINT fk_unit_program_applic FOREIGN KEY (app_status_cd) 
            REFERENCES camdmd.applicability_status_code (app_status_cd);
ALTER TABLE camd.unit_program
        ADD CONSTRAINT fk_unit_program_class FOREIGN KEY (prg_cd, class_cd) 
            REFERENCES camdmd.program_class (prg_cd, class_cd);
ALTER TABLE camd.unit_program
        ADD CONSTRAINT fk_unit_program_id FOREIGN KEY (prg_id) 
            REFERENCES camd.program (prg_id);
ALTER TABLE camd.unit_program
        ADD CONSTRAINT fk_unit_program_nonstandard_cd FOREIGN KEY (nonstandard_cd) 
            REFERENCES camdmd.nonstandard_code (nonstandard_cd);
ALTER TABLE camd.unit_program
        ADD CONSTRAINT fk_unit_program_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS idx_unit_program_applic 
  ON camd.unit_program (app_status_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_class 
  ON camd.unit_program (prg_cd,class_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_id 
  ON camd.unit_program (prg_id);
CREATE INDEX IF NOT EXISTS idx_unit_program_nonstandard 
  ON camd.unit_program (nonstandard_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_unit 
  ON camd.unit_program (unit_id);
CREATE INDEX IF NOT EXISTS idx_unit_program_unit_class 
  ON camd.unit_program (unit_id,class_cd);
CREATE INDEX IF NOT EXISTS idx_unit_program_unit_program 
  ON camd.unit_program (unit_id,prg_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_program 
  ON camd.unit_program (up_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_program 
  ON camd.unit_program (unit_id,prg_id);