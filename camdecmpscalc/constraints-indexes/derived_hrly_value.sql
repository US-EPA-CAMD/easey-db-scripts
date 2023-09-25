ALTER TABLE IF EXISTS camdecmpscalc.derived_hrly_value
    ADD CONSTRAINT pk_derived_hrly_value PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_derived_hrly_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_chk_session_id
    ON camdecmpscalc.derived_hrly_value USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_derv_id
    ON camdecmpscalc.derived_hrly_value USING btree
    (derv_id COLLATE pg_catalog."default" ASC NULLS LAST);
