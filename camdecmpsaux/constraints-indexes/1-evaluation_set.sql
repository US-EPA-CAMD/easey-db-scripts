ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set
	  ADD CONSTRAINT pk_evaluation_set PRIMARY KEY (evaluation_set_id),
    ADD CONSTRAINT fk_evaluation_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_evaluation_set_mon_plan_id
    ON camdecmpsaux.evaluation_set USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_set_fac_id
    ON camdecmpsaux.evaluation_set USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_set_oris_code
    ON camdecmpsaux.evaluation_set USING btree
    (oris_code ASC NULLS LAST);