ALTER TABLE camd.contact_relation
        ADD CONSTRAINT fk_contact_relation_cnt FOREIGN KEY (cnt_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camd.contact_relation
        ADD CONSTRAINT fk_contact_relation_ppl FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camd.contact_relation
        ADD CONSTRAINT fk_contact_relation_type FOREIGN KEY (relation_type_cd) 
            REFERENCES camdmd.relation_type_code (relation_type_cd);

CREATE INDEX IF NOT EXISTS idx_contact_relation_active 
  ON camd.contact_relation (cnt_id,ppl_id,relation_type_cd,begin_date,end_date);
CREATE INDEX IF NOT EXISTS idx_contact_relation_agent 
  ON camd.contact_relation (agent_id);
CREATE INDEX IF NOT EXISTS idx_contact_relation_cnt 
  ON camd.contact_relation (cnt_id);
CREATE INDEX IF NOT EXISTS idx_contact_relation_ppl 
  ON camd.contact_relation (ppl_id);
CREATE INDEX IF NOT EXISTS idx_contact_relation_rep 
  ON camd.contact_relation (rep_id);
CREATE INDEX IF NOT EXISTS idx_contact_relation_type 
  ON camd.contact_relation (relation_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_contact_relation 
  ON camd.contact_relation (cnt_rel_id);