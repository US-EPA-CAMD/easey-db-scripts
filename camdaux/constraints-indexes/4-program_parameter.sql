ALTER TABLE camdaux.program_parameter
        ADD CONSTRAINT fk_prg_param_prg_id FOREIGN KEY (prg_id) 
            REFERENCES camd.program (prg_id);

CREATE INDEX IF NOT EXISTS idx_prg_param_begin_rpt_period 
  ON camdaux.program_parameter (begin_rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_prg_param_end_rpt_period 
  ON camdaux.program_parameter (end_rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_prg_param_param_cd 
  ON camdaux.program_parameter (parameter_cd);
CREATE INDEX IF NOT EXISTS idx_prg_param_prg_id 
  ON camdaux.program_parameter (prg_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_program_parameter 
  ON camdaux.program_parameter (prg_param_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_prg_param_begin 
  ON camdaux.program_parameter (prg_id,parameter_cd,begin_rpt_period_id);