CREATE UNIQUE INDEX IF NOT EXISTS pk_compliance_stack_config 
  ON camdams.compliance_stack_config (comp_stack_config_id);

ALTER TABLE camdams.compliance_stack_config
        ADD CONSTRAINT fk_comp_stack_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.compliance_stack_config
        ADD CONSTRAINT fk_comp_stack_conf_comp_period FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.compliance_stack_config
        ADD CONSTRAINT fk_comp_stack_conf_fac FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdams.compliance_stack_config
        ADD CONSTRAINT fk_comp_stack_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);