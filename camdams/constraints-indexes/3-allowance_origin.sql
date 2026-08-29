CREATE UNIQUE INDEX IF NOT EXISTS pk_allow_origin 
  ON camdams.allowance_origin (allow_origin_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_allow_origin_prg_cy_alwtyp 
  ON camdams.allowance_origin (prg_cd,comp_year,allow_type_cd);

ALTER TABLE camdams.allowance_origin
        ADD CONSTRAINT fk_allow_origin_allow_type FOREIGN KEY (allow_type_cd) 
            REFERENCES camdmd.allowance_type_code (allow_type_cd);
ALTER TABLE camdams.allowance_origin
        ADD CONSTRAINT fk_allow_origin_prg FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);