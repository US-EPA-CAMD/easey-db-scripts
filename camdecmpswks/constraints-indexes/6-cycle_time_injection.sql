ALTER TABLE IF EXISTS camdecmpswks.cycle_time_injection
    ADD CONSTRAINT pk_cycle_time_injection PRIMARY KEY (cycle_time_inj_id),
    ADD CONSTRAINT fk_cycle_time_injection_cycle_time_summary FOREIGN KEY (cycle_time_sum_id)
        REFERENCES camdecmpswks.cycle_time_summary (cycle_time_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_cycle_time_injection_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_cycle_time_injection_cycle_time_sum_id
    ON camdecmpswks.cycle_time_injection USING btree
    (cycle_time_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_cycle_time_injection_gas_level_cd
    ON camdecmpswks.cycle_time_injection USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
