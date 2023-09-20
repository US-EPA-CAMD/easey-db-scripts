ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_process
	  ADD CONSTRAINT pk_check_catalog_process PRIMARY KEY (check_catalog_id, process_cd);

CREATE INDEX IF NOT EXISTS idx_check_catalog_process_check_catalog_id
    ON camdecmpsmd.check_catalog_process USING btree
    (check_catalog_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_process_process_cd
    ON camdecmpsmd.check_catalog_process USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);
