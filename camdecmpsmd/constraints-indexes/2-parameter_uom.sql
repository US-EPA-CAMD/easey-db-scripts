ALTER TABLE IF EXISTS camdecmpsmd.parameter_uom
    ADD CONSTRAINT pk_parameter_uom PRIMARY KEY (param_id),
    ADD CONSTRAINT fk_parameter_uom_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_parameter_uom_units_of_measure_code FOREIGN KEY (uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_parameter_uom_parameter_cd
    ON camdecmpsmd.parameter_uom USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_parameter_uom_uom_cd
    ON camdecmpsmd.parameter_uom USING btree
    (uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
