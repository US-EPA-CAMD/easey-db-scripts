ALTER TABLE camd.nue_unit_fuel
        ADD CONSTRAINT fk_nue_unit_fuel_unit_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_nue_unit_fuel 
  ON camd.nue_unit_fuel (uf_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_nue_unit_fuel 
  ON camd.nue_unit_fuel (unit_id,fuel_type,begin_date);