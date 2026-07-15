ALTER TABLE camd.email_generator_email
        ADD CONSTRAINT fk_email_bcc_gen_group FOREIGN KEY (bcc_email_gen_group_id) 
            REFERENCES camd.email_generator_group (email_gen_group_id);
ALTER TABLE camd.email_generator_email
        ADD CONSTRAINT fk_email_cc_gen_group FOREIGN KEY (cc_email_gen_group_id) 
            REFERENCES camd.email_generator_group (email_gen_group_id);
ALTER TABLE camd.email_generator_email
        ADD CONSTRAINT fk_email_gen_body FOREIGN KEY (email_gen_body_id) 
            REFERENCES camd.email_generator_body (email_gen_body_id);
ALTER TABLE camd.email_generator_email
        ADD CONSTRAINT fk_email_to_gen_group FOREIGN KEY (to_email_gen_group_id) 
            REFERENCES camd.email_generator_group (email_gen_group_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_email_gen_email 
  ON camd.email_generator_email (email_gen_email_id);