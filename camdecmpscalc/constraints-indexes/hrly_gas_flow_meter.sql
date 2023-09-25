ALTER TABLE IF EXISTS camdecmpscalc.hrly_gas_flow_meter
    ADD CONSTRAINT pk_hrly_gas_flow_meter PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_hrly_gas_flow_meter_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_chk_session_id
    ON camdecmpscalc.hrly_gas_flow_meter USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_hrly_gas_flow_meter_id
    ON camdecmpscalc.hrly_gas_flow_meter USING btree
    (hrly_gas_flow_meter_id COLLATE pg_catalog."default" ASC NULLS LAST);
