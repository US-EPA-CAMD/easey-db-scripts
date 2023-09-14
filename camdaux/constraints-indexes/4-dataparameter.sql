ALTER TABLE IF EXISTS camdaux.dataparameter
    ADD CONSTRAINT pk_dataparameter PRIMARY KEY (parameter_id),
    ADD CONSTRAINT fk_dataparameter_datatable FOREIGN KEY (datatable_id)
        REFERENCES camdaux.datatable (datatable_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_dataparameter_datatable_id
    ON camdaux.dataparameter USING btree
    (datatable_id ASC NULLS LAST);