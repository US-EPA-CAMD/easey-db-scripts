ALTER TABLE IF EXISTS camdaux.bulk_file_queue
    ADD CONSTRAINT pk_bulk_file_queue PRIMARY KEY (job_id);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_status_cd
    ON camdaux.bulk_file_queue USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_year
    ON camdaux.bulk_file_queue USING btree
    (year ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_quarter
    ON camdaux.bulk_file_queue USING btree
    (quarter ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_state_cd
    ON camdaux.bulk_file_queue USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_data_type
    ON camdaux.bulk_file_queue USING btree
    (data_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_sub_type
    ON camdaux.bulk_file_queue USING btree
    (sub_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_file_name
    ON camdaux.bulk_file_queue USING btree
    (file_name COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_bulk_file_queue_program_cd
    ON camdaux.bulk_file_queue USING btree
    (program_cd COLLATE pg_catalog."default" ASC NULLS LAST);