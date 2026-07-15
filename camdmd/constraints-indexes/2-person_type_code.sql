ALTER TABLE camdmd.person_type_code
        ADD CONSTRAINT fk_person_type_code_group FOREIGN KEY (person_type_group_cd) 
            REFERENCES camdmd.person_type_group_code (person_type_group_cd);

CREATE INDEX IF NOT EXISTS idx_person_type_code_group 
  ON camdmd.person_type_code (person_type_group_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_person_type_code 
  ON camdmd.person_type_code (person_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS uq_person_type_code_desc 
  ON camdmd.person_type_code (person_type_description);