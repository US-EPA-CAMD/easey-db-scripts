CREATE UNIQUE INDEX IF NOT EXISTS pk_arp_optin_allocation 
  ON camdams.arp_optin_allocation (unit_id);

ALTER TABLE camdams.arp_optin_allocation
        ADD CONSTRAINT fk_arp_optin_allocation_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);