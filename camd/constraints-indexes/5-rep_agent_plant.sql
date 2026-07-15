ALTER TABLE camd.rep_agent_plant
        ADD CONSTRAINT fk_rep_agent_plant_cnt_rel FOREIGN KEY (cnt_rel_id) 
            REFERENCES camd.contact_relation (cnt_rel_id);
ALTER TABLE camd.rep_agent_plant
        ADD CONSTRAINT fk_rep_agent_plant_fac FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);

CREATE INDEX IF NOT EXISTS idx_rep_agent_plant_active 
  ON camd.rep_agent_plant (cnt_rel_id,fac_id,begin_date,end_date);
CREATE INDEX IF NOT EXISTS idx_rep_agent_plant_cnt_rel 
  ON camd.rep_agent_plant (cnt_rel_id);
CREATE INDEX IF NOT EXISTS idx_rep_agent_plant_fac 
  ON camd.rep_agent_plant (fac_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_rep_agent_plant 
  ON camd.rep_agent_plant (rep_agent_plant_id);