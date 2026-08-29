ALTER TABLE camd.applic_answers
        ADD CONSTRAINT fk_applic_ans_applic_determn FOREIGN KEY (apd_id) 
            REFERENCES camd.applic_determination (apd_id);