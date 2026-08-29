CREATE INDEX IF NOT EXISTS idx_allow_block_allow_stat_cd 
  ON camdams.allowance_block (allow_status_cd);
CREATE INDEX IF NOT EXISTS idx_allow_block_allow_type_cd 
  ON camdams.allowance_block (allow_type_cd);
CREATE INDEX IF NOT EXISTS idx_allow_block_allow_vint 
  ON camdams.allowance_block (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_allow_block_unq 
  ON camdams.allowance_block (prg_vintage_id,begin_number);
CREATE UNIQUE INDEX IF NOT EXISTS pk_allowance_block 
  ON camdams.allowance_block (allow_block_id);

ALTER TABLE camdams.allowance_block
        ADD CONSTRAINT fk_allow_block_allow_stat_cd FOREIGN KEY (allow_status_cd) 
            REFERENCES camdmd.allowance_status_code (allow_status_cd);
ALTER TABLE camdams.allowance_block
        ADD CONSTRAINT fk_allow_block_allow_type_cd FOREIGN KEY (allow_type_cd) 
            REFERENCES camdmd.allowance_type_code (allow_type_cd);
ALTER TABLE camdams.allowance_block
        ADD CONSTRAINT fk_allow_block_allow_vint FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);