ALTER TABLE IF EXISTS camdecmpsmd.severity_code
    ADD CONSTRAINT pk_severity_code PRIMARY KEY (severity_cd),
    ADD CONSTRAINT uq_severity_code_description UNIQUE (severity_cd_description),
    ADD CONSTRAINT uq_severity_code_severity_level UNIQUE (severity_level),
    ADD CONSTRAINT fk_severity_code_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_severity_code_eval_status_cd
    ON camdecmpsmd.severity_code USING btree
    (eval_status_cd ASC NULLS LAST);
