ALTER TABLE camd.unit_program_phase
        ADD CONSTRAINT fk_up_id_unit_program_phase FOREIGN KEY (up_id) 
            REFERENCES camd.unit_program (up_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_prg_phase 
  ON camd.unit_program_phase (unit_prog_phase_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_prog_phase_upid_bgnyr 
  ON camd.unit_program_phase (up_id,begin_year);