ALTER TABLE IF EXISTS camdecmpscalc.flow_to_load_reference
    ADD CONSTRAINT pk_flow_to_load_reference PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_flow_to_load_reference_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_chk_session_id
    ON camdecmpscalc.flow_to_load_reference USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_flow_load_ref_id
    ON camdecmpscalc.flow_to_load_reference USING btree
    (flow_load_ref_id COLLATE pg_catalog."default" ASC NULLS LAST);
