CREATE INDEX IF NOT EXISTS idx_state_unit_alloc_prg_vint 
  ON camdams.state_unit_allocation (prg_vintage_id);
CREATE INDEX IF NOT EXISTS idx_state_unit_alloc_transtype 
  ON camdams.state_unit_allocation (trans_type_cd);
CREATE INDEX IF NOT EXISTS idx_state_unit_alloc_unit 
  ON camdams.state_unit_allocation (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_state_unit_alloc 
  ON camdams.state_unit_allocation (state_unit_alloc_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq1_state_unit_alloc 
  ON camdams.state_unit_allocation (unit_id,prg_vintage_id,trans_type_cd);

ALTER TABLE camdams.state_unit_allocation
        ADD CONSTRAINT fk_state_unit_allocation_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);
ALTER TABLE camdams.state_unit_allocation
        ADD CONSTRAINT fk_state_unit_alloc_prg_vint FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.state_unit_allocation
        ADD CONSTRAINT fk_state_unit_alloc_trans_type FOREIGN KEY (trans_type_cd) 
            REFERENCES camdmd.transaction_type_code (trans_type_cd);