ALTER TABLE IF EXISTS camdaux.dataset
    ADD CONSTRAINT pk_dataset PRIMARY KEY (dataset_cd),
    ADD CONSTRAINT ck_group_cd CHECK (group_cd::text = ANY (ARRAY['MDM'::text, 'MDMREL'::text, 'REPORT'::text, 'EMVIEW'::text]));

CREATE INDEX IF NOT EXISTS idx_dataset_group_cd
    ON camdaux.dataset USING btree
    (group_cd COLLATE pg_catalog."default" ASC NULLS LAST);