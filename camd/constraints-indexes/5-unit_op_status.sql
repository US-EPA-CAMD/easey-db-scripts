ALTER TABLE camd.unit_op_status
        ADD CONSTRAINT fk_unit_op_status_code FOREIGN KEY (op_status_cd) 
            REFERENCES camdmd.operating_status_code (op_status_cd);
ALTER TABLE camd.unit_op_status
        ADD CONSTRAINT fk_unit_op_status_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS idx_unit_op_status_code 
  ON camd.unit_op_status (op_status_cd);
CREATE INDEX IF NOT EXISTS idx_unit_op_status_unit 
  ON camd.unit_op_status (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_op_status 
  ON camd.unit_op_status (unit_op_status_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_op_status 
  ON camd.unit_op_status (unit_id,op_status_cd,begin_date);