CREATE INDEX IF NOT EXISTS idx_csosg2_svc_account 
  ON camdams.csosg2_safety_valve_conversion (account_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_svc_csosg2_trans 
  ON camdams.csosg2_safety_valve_conversion (csosg2_trans_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_svc_csosg3_trans 
  ON camdams.csosg2_safety_valve_conversion (csosg3_trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_safety_valve_conv 
  ON camdams.csosg2_safety_valve_conversion (csosg2_safety_valve_conv_id);

ALTER TABLE camdams.csosg2_safety_valve_conversion
        ADD CONSTRAINT fk_csosg2_svc_account FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.csosg2_safety_valve_conversion
        ADD CONSTRAINT fk_csosg2_svc_csosg2_trans FOREIGN KEY (csosg2_trans_id) 
            REFERENCES camdams.transaction (trans_id);
ALTER TABLE camdams.csosg2_safety_valve_conversion
        ADD CONSTRAINT fk_csosg2_svc_csosg3_trans FOREIGN KEY (csosg3_trans_id) 
            REFERENCES camdams.transaction (trans_id);