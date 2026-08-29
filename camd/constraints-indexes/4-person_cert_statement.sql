ALTER TABLE camd.person_cert_statement
        ADD CONSTRAINT fk_person_cert_statement_cert FOREIGN KEY (cert_statement_id) 
            REFERENCES camdmd.cert_statement (cert_statement_id);
ALTER TABLE camd.person_cert_statement
        ADD CONSTRAINT fk_person_cert_statement_pers FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);

CREATE INDEX IF NOT EXISTS idx_person_cert_statement_cert 
  ON camd.person_cert_statement (cert_statement_id);
CREATE INDEX IF NOT EXISTS idx_person_cert_statement_pers 
  ON camd.person_cert_statement (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_person_cert_statement 
  ON camd.person_cert_statement (person_cert_statement_id);
CREATE UNIQUE INDEX IF NOT EXISTS udx_person_cert_statement 
  ON camd.person_cert_statement (ppl_id,cert_statement_id);