ALTER TABLE IF EXISTS camdaux.datatable
    ADD CONSTRAINT pk_datatable PRIMARY KEY (datatable_id),
    ADD CONSTRAINT uq_datatable UNIQUE (dataset_cd, template_cd, table_order),
    ADD CONSTRAINT fk_datatable_dataset FOREIGN KEY (dataset_cd)
        REFERENCES camdaux.dataset (dataset_cd) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_datatable_template_code FOREIGN KEY (template_cd)
        REFERENCES camdaux.template_code (template_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_datatable_dataset_cd
    ON camdaux.datatable USING btree
    (dataset_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_datatable_template_cd
    ON camdaux.datatable USING btree
    (template_cd COLLATE pg_catalog."default" ASC NULLS LAST);
