ALTER TABLE IF EXISTS camdaux.inventory_status_log
    ADD CONSTRAINT pk_inventory_status_log PRIMARY KEY (inventory_status_log_id),
    ADD CONSTRAINT fk_inventory_status_log_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_inventory_status_log_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_inventory_status_log_fac_id
    ON camdaux.inventory_status_log USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_inventory_status_log_unit_id
    ON camdaux.inventory_status_log USING btree
    (unit_id ASC NULLS LAST);
