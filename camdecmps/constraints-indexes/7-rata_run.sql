ALTER TABLE IF EXISTS camdecmps.rata_run
    ADD CONSTRAINT pk_rata_run PRIMARY KEY (rata_run_id),
    ADD CONSTRAINT fk_rata_run_rata_summary FOREIGN KEY (rata_sum_id)
        REFERENCES camdecmps.rata_summary (rata_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_run_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.run_status_code (run_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_run_run_status_cd
    ON camdecmps.rata_run USING btree
    (run_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_run_rata_sum_id
    ON camdecmps.rata_run USING btree
    (rata_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
