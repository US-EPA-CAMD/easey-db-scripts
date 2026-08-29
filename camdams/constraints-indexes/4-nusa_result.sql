CREATE INDEX IF NOT EXISTS idx_nusa_result_001 
  ON camdams.nusa_result (prg_vintage_id,nusa_round,final_ind,state,indian_country_ind);
CREATE UNIQUE INDEX IF NOT EXISTS pk_nusa_result 
  ON camdams.nusa_result (nusa_result_id);

ALTER TABLE camdams.nusa_result
        ADD CONSTRAINT fk_nusa_result_prgvintage FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.nusa_result
        ADD CONSTRAINT fk_nusa_result_state FOREIGN KEY (state) 
            REFERENCES camdmd.state_code (state_cd);