ALTER TABLE IF EXISTS camd.plant_person
    ADD CONSTRAINT pk_plant_person PRIMARY KEY (fac_ppl_id),
    ADD CONSTRAINT fk_plant_person_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_person_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_person_responsibility FOREIGN KEY (responsibility_id)
        REFERENCES camdmd.responsibility (responsibility_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_plant_person_plant
    ON camd.plant_person USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_person_prg_cd
    ON camd.plant_person USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_person_responsibility_id
    ON camd.plant_person USING btree
    (responsibility_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX idx_plant_person_lk
    ON camd.plant_person USING btree
    (fac_id ASC NULLS LAST, ppl_id ASC NULLS LAST, responsibility_id COLLATE pg_catalog."default" ASC NULLS LAST, prg_cd COLLATE pg_catalog."default" ASC NULLS LAST, begin_date ASC NULLS LAST, end_date ASC NULLS LAST);

CREATE INDEX idx_plant_person_person
    ON camd.plant_person USING btree
    (ppl_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_person_pp_end_date
    ON camd.plant_person USING btree
    (fac_id ASC NULLS LAST, ppl_id ASC NULLS LAST, end_date ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_person_fac_id
    ON camd.plant_person USING btree
    (fac_id ASC NULLS LAST, ppl_id ASC NULLS LAST, responsibility_id COLLATE pg_catalog."default" ASC NULLS LAST, prg_cd COLLATE pg_catalog."default" ASC NULLS LAST, begin_date ASC NULLS LAST, end_date ASC NULLS LAST);
*/