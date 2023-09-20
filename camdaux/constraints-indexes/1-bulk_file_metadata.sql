ALTER TABLE IF EXISTS camdaux.bulk_file_metadata
    ADD CONSTRAINT pk_bulk_file_metadata PRIMARY KEY (file_name),
    ADD CONSTRAINT uq_bulk_file_metadata_s3_path UNIQUE (s3_path);

CREATE INDEX IF NOT EXISTS idx_bulk_file_metadata_s3_path
    ON camdaux.bulk_file_metadata USING btree
    (s3_path COLLATE pg_catalog."default" ASC NULLS LAST);
