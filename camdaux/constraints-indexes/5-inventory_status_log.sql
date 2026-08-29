ALTER TABLE camdaux.inventory_status_log
        ADD CONSTRAINT fk_inv_stat_log_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdaux.inventory_status_log
        ADD CONSTRAINT fk_inv_stat_log_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_inventory_status_log 
  ON camdaux.inventory_status_log (inventory_status_log_id);