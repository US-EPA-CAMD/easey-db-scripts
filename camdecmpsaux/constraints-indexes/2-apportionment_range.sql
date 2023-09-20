ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range
	  ADD CONSTRAINT pk_apportionment_range PRIMARY KEY (apport_range_id),
    ADD CONSTRAINT fk_apportionment_range_apportionment FOREIGN KEY (apport_id)
        REFERENCES camdecmpsaux.apportionment (apport_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_apportionment_range_apport_id
    ON camdecmpsaux.apportionment_range USING btree
    (apport_id ASC NULLS LAST);
