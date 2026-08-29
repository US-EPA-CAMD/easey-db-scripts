ALTER TABLE camdmd.cert_statement_text
        ADD CONSTRAINT fk_cert_statement_text_cert FOREIGN KEY (cert_statement_id) 
            REFERENCES camdmd.cert_statement (cert_statement_id);
ALTER TABLE camdmd.cert_statement_text
        ADD CONSTRAINT fk_cert_statement_text_text FOREIGN KEY (cert_text_id) 
            REFERENCES camdmd.cert_text (cert_text_id);

CREATE INDEX IF NOT EXISTS idx_cert_statement_text_cert 
  ON camdmd.cert_statement_text (cert_statement_id);
CREATE INDEX IF NOT EXISTS idx_cert_statement_text_text 
  ON camdmd.cert_statement_text (cert_text_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cert_statement_text 
  ON camdmd.cert_statement_text (cert_statement_text_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_cert_statement_text_display 
  ON camdmd.cert_statement_text (cert_statement_id,display_order);
CREATE UNIQUE INDEX IF NOT EXISTS uq_cert_statement_text_text 
  ON camdmd.cert_statement_text (cert_statement_id,cert_text_id);