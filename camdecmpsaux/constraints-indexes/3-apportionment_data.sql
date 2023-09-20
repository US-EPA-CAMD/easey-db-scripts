ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data
  	ADD CONSTRAINT pk_apportionment_data PRIMARY KEY (apport_data_id),
    ADD CONSTRAINT fk_apportionment_data_apportionment_range FOREIGN KEY (apport_range_id)
        REFERENCES camdecmpsaux.apportionment_range (apport_range_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_apportionment_data_apport_range_id
    ON camdecmpsaux.apportionment_data USING btree
    (apport_range_id ASC NULLS LAST);