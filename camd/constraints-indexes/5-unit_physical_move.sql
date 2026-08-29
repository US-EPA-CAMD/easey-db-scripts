ALTER TABLE camd.unit_physical_move
        ADD CONSTRAINT fk_unit_physical_move_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_physical_move 
  ON camd.unit_physical_move (unit_id,effective_date);