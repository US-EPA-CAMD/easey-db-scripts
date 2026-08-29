ALTER TABLE camdmd.responsibility_group
        ADD CONSTRAINT fk_responsibility_group_ptg FOREIGN KEY (person_type_group_cd) 
            REFERENCES camdmd.person_type_group_code (person_type_group_cd);
ALTER TABLE camdmd.responsibility_group
        ADD CONSTRAINT fk_responsibility_group_rsp FOREIGN KEY (responsibility_id) 
            REFERENCES camdmd.responsibility (responsibility_id);

CREATE INDEX IF NOT EXISTS idx_responsibility_group_ptg 
  ON camdmd.responsibility_group (person_type_group_cd);
CREATE INDEX IF NOT EXISTS idx_responsibility_group_rsp 
  ON camdmd.responsibility_group (responsibility_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_responsibility_group 
  ON camdmd.responsibility_group (responsibility_group_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_responsibility_group 
  ON camdmd.responsibility_group (responsibility_id,person_type_group_cd);