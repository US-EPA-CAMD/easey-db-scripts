ALTER TABLE IF EXISTS camdecmpswks.unit
    ADD CONSTRAINT pk_unit PRIMARY KEY (unit_id),
    ADD CONSTRAINT uq_unit UNIQUE (fac_id, unitid),
    ADD CONSTRAINT fk_unit_naics_code FOREIGN KEY (naics_cd)
        REFERENCES camdmd.naics_code (naics_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_source_category_code FOREIGN KEY (source_category_cd)
        REFERENCES camdmd.source_category_code (source_category_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_naics_cd
    ON camdecmpswks.unit USING btree
    (naics_cd ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fac_id
    ON camdecmpswks.unit USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_source_category_cd
    ON camdecmpswks.unit USING btree
    (source_category_cd COLLATE pg_catalog."default" ASC NULLS LAST);
