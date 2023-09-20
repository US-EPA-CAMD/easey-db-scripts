ALTER TABLE IF EXISTS camdecmps.used_identifier
    ADD CONSTRAINT pk_used_identifier PRIMARY KEY (mon_loc_id, table_cd, identifier),
    ADD CONSTRAINT fk_used_identifier_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_used_identifier_mon_loc_id
    ON camdecmps.used_identifier USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_table_cd
    ON camdecmps.used_identifier USING btree
    (table_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_identifier
    ON camdecmps.used_identifier USING btree
    (identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_type_or_parameter_cd
    ON camdecmps.used_identifier USING btree
    (type_or_parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_formula_or_basis_cd
    ON camdecmps.used_identifier USING btree
    (formula_or_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);
