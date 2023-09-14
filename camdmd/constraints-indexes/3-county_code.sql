ALTER TABLE IF EXISTS camdmd.county_code
    ADD CONSTRAINT pk_county_code PRIMARY KEY (county_cd),
    ADD CONSTRAINT uq_county_code_number UNIQUE (county_number),
    ADD CONSTRAINT uq_county_code_name_by_state UNIQUE (county_name, state_cd),    
    ADD CONSTRAINT fk_county_code_state_code FOREIGN KEY (state_cd)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_county_code_state_cd
    ON camdmd.county_code USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST);
