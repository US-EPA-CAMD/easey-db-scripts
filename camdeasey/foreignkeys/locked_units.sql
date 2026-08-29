ALTER TABLE camdeasey.locked_units
        ADD CONSTRAINT locked_units_r01 FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);
ALTER TABLE camdeasey.locked_units
        ADD CONSTRAINT locked_units_r02 FOREIGN KEY (activity_id) 
            REFERENCES camdeasey.activity_log (activity_id);