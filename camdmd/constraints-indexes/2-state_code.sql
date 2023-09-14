ALTER TABLE IF EXISTS camdmd.state_code
    ADD CONSTRAINT pk_state_code PRIMARY KEY (state_cd),
    ADD CONSTRAINT uq_state_code_name UNIQUE (state_name),
    ADD CONSTRAINT fk_state_code_epa_region_code FOREIGN KEY (epa_region)
        REFERENCES camdmd.epa_region_code (epa_region_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_state_code_epa_region
    ON camdmd.state_code USING btree
    (epa_region ASC NULLS LAST);
