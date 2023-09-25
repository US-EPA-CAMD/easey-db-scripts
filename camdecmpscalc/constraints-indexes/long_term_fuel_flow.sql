ALTER TABLE IF EXISTS camdecmpscalc.long_term_fuel_flow
    ADD CONSTRAINT pk_long_term_fuel_flow PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_long_term_fuel_flow_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_chk_session_id
    ON camdecmpscalc.long_term_fuel_flow USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_ltff_id
    ON camdecmpscalc.long_term_fuel_flow USING btree
    (ltff_id COLLATE pg_catalog."default" ASC NULLS LAST);
