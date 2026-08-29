ALTER TABLE camd.unit_logical_move
        ADD CONSTRAINT fk_unit_logical_move_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_logical_move 
  ON camd.unit_logical_move (unit_id,effective_date);