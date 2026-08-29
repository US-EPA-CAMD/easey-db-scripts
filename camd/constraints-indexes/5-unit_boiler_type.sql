ALTER TABLE camd.unit_boiler_type
        ADD CONSTRAINT fk_unit_boiler_type_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);
ALTER TABLE camd.unit_boiler_type
        ADD CONSTRAINT fk_unit_boiler_type_unit_type FOREIGN KEY (unit_type_cd) 
            REFERENCES camdmd.unit_type_code (unit_type_cd);

CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_unit 
  ON camd.unit_boiler_type (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_boiler_type 
  ON camd.unit_boiler_type (unit_boiler_type_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_boiler_type 
  ON camd.unit_boiler_type (unit_id,unit_type_cd,begin_date);