ALTER TABLE camd.applic_result
        ADD CONSTRAINT fk_applic_res_applic_det FOREIGN KEY (apd_id) 
            REFERENCES camd.applic_determination (apd_id);