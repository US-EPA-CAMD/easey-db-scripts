ALTER TABLE camdmd.event_action
        ADD CONSTRAINT fk_event_action_event_xsd FOREIGN KEY (xsd_id) 
            REFERENCES camdmd.xml_schema_definition (xsd_id);

CREATE INDEX IF NOT EXISTS idx_event_action_event_xsd 
  ON camdmd.event_action (xsd_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_event_action 
  ON camdmd.event_action (event_action_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_event_action_desc 
  ON camdmd.event_action (event_action_description);