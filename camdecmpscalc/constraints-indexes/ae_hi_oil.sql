ALTER TABLE IF EXISTS camdecmpscalc.ae_hi_oil
    ADD CONSTRAINT pk_ae_hi_oil PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_ae_hi_oil_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_chk_session_id
    ON camdecmpscalc.ae_hi_oil USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_ae_hi_oil_id
    ON camdecmpscalc.ae_hi_oil USING btree
    (ae_hi_oil_id COLLATE pg_catalog."default" ASC NULLS LAST);
