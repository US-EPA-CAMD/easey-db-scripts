ALTER TABLE camdaux.xml_log
        ADD CONSTRAINT fk_xml_log_xsd FOREIGN KEY (xsd_id) 
            REFERENCES camdmd.xml_schema_definition (xsd_id);

CREATE INDEX IF NOT EXISTS idx_xml_log_xsd 
  ON camdaux.xml_log (xsd_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_xml_log 
  ON camdaux.xml_log (xml_log_id);
CREATE INDEX IF NOT EXISTS xml_log_xml_index 
  ON camdaux.xml_log (sys_makexml(0,"sys_nc00004$"));