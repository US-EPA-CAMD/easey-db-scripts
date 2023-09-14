ALTER TABLE IF EXISTS camdaux.datacolumn
    ADD CONSTRAINT pk_datacolumn PRIMARY KEY (datacolumn_id),
    ADD CONSTRAINT fk_datacolumn_datatable FOREIGN KEY (datatable_id)
        REFERENCES camdaux.datatable (datatable_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_datacolumn_datatable_id
    ON camdaux.datacolumn USING btree
    (datatable_id ASC NULLS LAST);