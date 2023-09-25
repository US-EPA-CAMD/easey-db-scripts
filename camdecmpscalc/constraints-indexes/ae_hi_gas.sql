ALTER TABLE IF EXISTS camdecmpscalc.ae_hi_gas
    ADD CONSTRAINT pk_ae_hi_gas PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_ae_hi_gas_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_chk_session_id
    ON camdecmpscalc.ae_hi_gas USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_ae_hi_gas_id
    ON camdecmpscalc.ae_hi_gas USING btree
    (ae_hi_gas_id COLLATE pg_catalog."default" ASC NULLS LAST);
