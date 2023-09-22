ALTER TABLE IF EXISTS camd.unit_exemption
    ADD CONSTRAINT pk_unit_exemption PRIMARY KEY (unit_exempt_id),
    ADD CONSTRAINT uq_unit_exemption UNIQUE (unit_id, begin_date),
    ADD CONSTRAINT fk_unit_exemption_exemption_type_code FOREIGN KEY (exemption_type_cd)
        REFERENCES camdmd.exemption_type_code (exemption_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_exemption_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_exemption_exemption_type_cd
    ON camd.unit_exemption USING btree
    (exemption_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_exemption_unit_id
    ON camd.unit_exemption USING btree
    (unit_id ASC NULLS LAST);

/*
CREATE INDEX idx_unit_exemption_submit
    ON camd.unit_exemption USING btree
    (submitter_ppl_id ASC NULLS LAST);
*/