ALTER TABLE IF EXISTS camdecmps.analyzer_range
    ADD CONSTRAINT pk_analyzer_range PRIMARY KEY (analyzer_range_id),
    ADD CONSTRAINT fk_analyzer_range_analyzer_range_code FOREIGN KEY (analyzer_range_cd)
        REFERENCES camdecmpsmd.analyzer_range_code (analyzer_range_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_analyzer_range_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT ck_analyzer_range_begin_date_end_date CHECK (begin_date <= end_date);

CREATE INDEX IF NOT EXISTS idx_analyzer_range_analyzer_range_cd
    ON camdecmps.analyzer_range USING btree
    (analyzer_range_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_analyzer_range_component_id
    ON camdecmps.analyzer_range USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);
