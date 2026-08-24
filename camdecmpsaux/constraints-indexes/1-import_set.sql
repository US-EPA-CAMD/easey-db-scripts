ALTER TABLE IF EXISTS camdecmpsaux.import_set
    ADD CONSTRAINT pk_import_set PRIMARY KEY (import_set_id);

CREATE INDEX IF NOT EXISTS idx_import_set_user_id
    ON camdecmpsaux.import_set USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_import_set_status_cd
    ON camdecmpsaux.import_set USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
