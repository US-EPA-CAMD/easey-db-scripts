ALTER TABLE IF EXISTS camdecmpswks.protocol_gas
    ADD CONSTRAINT pk_protocol_gas PRIMARY KEY (protocol_gas_id),
    ADD CONSTRAINT fk_protocol_gas_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_protocol_gas_protocol_gas_vendor FOREIGN KEY (vendor_id)
        REFERENCES camdecmps.protocol_gas_vendor (vendor_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_protocol_gas_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_protocol_gas_test_sum_id
    ON camdecmpswks.protocol_gas USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_gas_level_cd
    ON camdecmpswks.protocol_gas USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_gas_type_cd
    ON camdecmpswks.protocol_gas USING btree
    (gas_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_vendor_id
    ON camdecmpswks.protocol_gas USING btree
    (vendor_id COLLATE pg_catalog."default" ASC NULLS LAST);
