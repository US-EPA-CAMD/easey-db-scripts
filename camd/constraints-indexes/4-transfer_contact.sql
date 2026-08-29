ALTER TABLE camd.transfer_contact
        ADD CONSTRAINT fk_transfer_contact_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);

CREATE INDEX IF NOT EXISTS idx_transfer_contact_person 
  ON camd.transfer_contact (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transfer_contact 
  ON camd.transfer_contact (transfer_contact_id);