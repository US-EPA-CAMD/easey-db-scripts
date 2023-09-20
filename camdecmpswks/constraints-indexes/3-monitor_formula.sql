ALTER TABLE IF EXISTS camdecmpswks.monitor_formula
    ADD CONSTRAINT pk_monitor_formula PRIMARY KEY (mon_form_id),
    ADD CONSTRAINT fk_monitor_formula_equation_code FOREIGN KEY (equation_cd)
        REFERENCES camdecmpsmd.equation_code (equation_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_formula_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_formula_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_formula_equation_cd
    ON camdecmpswks.monitor_formula USING btree
    (equation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_mon_loc_id
    ON camdecmpswks.monitor_formula USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_formula_identifier
    ON camdecmpswks.monitor_formula USING btree
    (formula_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_parameter_cd
    ON camdecmpswks.monitor_formula USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
