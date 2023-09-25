ALTER TABLE IF EXISTS camdecmpscalc.hrly_fuel_flow
    ADD CONSTRAINT pk_hrly_fuel_flow PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_hrly_fuel_flow_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_chk_session_id
    ON camdecmpscalc.hrly_fuel_flow USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_hrly_fuel_flow_id
    ON camdecmpscalc.hrly_fuel_flow USING btree
    (hrly_fuel_flow_id COLLATE pg_catalog."default" ASC NULLS LAST);
