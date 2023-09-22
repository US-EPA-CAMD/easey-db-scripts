ALTER TABLE IF EXISTS camdecmpswks.rata_summary
    ADD CONSTRAINT pk_rata_summary PRIMARY KEY (rata_sum_id),
    ADD CONSTRAINT fk_rata_summary_aps_code FOREIGN KEY (aps_cd)
        REFERENCES camdecmpsmd.aps_code (aps_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_rata FOREIGN KEY (rata_id)
        REFERENCES camdecmpswks.rata (rata_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_summary_ref_method_code FOREIGN KEY (ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_ref_method_code_co2o2 FOREIGN KEY (co2_o2_ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_summary_aps_cd
    ON camdecmpswks.rata_summary USING btree
    (aps_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_co2_o2_ref_method_cd
    ON camdecmpswks.rata_summary USING btree
    (co2_o2_ref_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_op_level_cd
    ON camdecmpswks.rata_summary USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_rata_id
    ON camdecmpswks.rata_summary USING btree
    (rata_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_ref_method_cd
    ON camdecmpswks.rata_summary USING btree
    (ref_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
