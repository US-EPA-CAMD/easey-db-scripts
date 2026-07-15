ALTER TABLE camd.person
        ADD CONSTRAINT fk_person_agency FOREIGN KEY (agency_id) 
            REFERENCES camd.agency (agency_id);
ALTER TABLE camd.person
        ADD CONSTRAINT fk_person_company FOREIGN KEY (company_id) 
            REFERENCES camd.company (company_id);
ALTER TABLE camd.person
        ADD CONSTRAINT fk_person_person_type FOREIGN KEY (person_type_cd) 
            REFERENCES camdmd.person_type_code (person_type_cd);

CREATE INDEX IF NOT EXISTS idx_person_agency 
  ON camd.person (agency_id);
CREATE INDEX IF NOT EXISTS idx_person_company 
  ON camd.person (company_id);
CREATE INDEX IF NOT EXISTS idx_person_person_type 
  ON camd.person (person_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_person 
  ON camd.person (ppl_id);