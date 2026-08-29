CREATE UNIQUE INDEX IF NOT EXISTS pk_original_allocation 
  ON camdams.original_allocation (unit_id);

ALTER TABLE camdams.original_allocation
        ADD CONSTRAINT fk_original_allocation_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);