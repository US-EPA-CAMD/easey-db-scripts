ALTER TABLE camd.applic_determination
        ADD CONSTRAINT fk_ad_comp FOREIGN KEY (comp_id) 
            REFERENCES camd.company (company_id);
ALTER TABLE camd.applic_determination
        ADD CONSTRAINT fk_applic_det_people FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camd.applic_determination
        ADD CONSTRAINT fk_applic_source FOREIGN KEY (applic_source_code) 
            REFERENCES camdmd.applic_source (applic_source_code);
ALTER TABLE camd.applic_determination
        ADD CONSTRAINT fk_app_status FOREIGN KEY (app_status) 
            REFERENCES camdmd.applicability_status_code (app_status_cd);
ALTER TABLE camd.applic_determination
        ADD CONSTRAINT fk_unit_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS ad_pk 
  ON camd.applic_determination (apd_id);