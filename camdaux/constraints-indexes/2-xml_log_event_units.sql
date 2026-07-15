ALTER TABLE camdaux.xml_log_event_units
        ADD CONSTRAINT sys_c00104758 FOREIGN KEY (pkey) 
            REFERENCES camdaux.xml_log_event (key)
             ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS ix_xml_log_units 
  ON camdaux.xml_log_event_units (unit_id);
CREATE INDEX IF NOT EXISTS sys350324_350328_pky_idx 
  ON camdaux.xml_log_event_units (pkey);
CREATE INDEX IF NOT EXISTS sys350324_350328_rid_idx 
  ON camdaux.xml_log_event_units (rid);