ALTER TABLE camd.email_generator_email_attach
        ADD CONSTRAINT fk_email_gen_attach_attach FOREIGN KEY (email_gen_attach_id) 
            REFERENCES camd.email_generator_attachment (email_gen_attach_id);
ALTER TABLE camd.email_generator_email_attach
        ADD CONSTRAINT fk_email_gen_attach_email FOREIGN KEY (email_gen_email_id) 
            REFERENCES camd.email_generator_email (email_gen_email_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_email_gen_email_attach 
  ON camd.email_generator_email_attach (email_gen_email_id,email_gen_attach_id);