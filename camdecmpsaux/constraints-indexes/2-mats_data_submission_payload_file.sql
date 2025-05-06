ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission_payload_file
    ADD CONSTRAINT pk_mats_data_submission_payload_file PRIMARY KEY (mats_data_sub_payload_file_id),
    ADD CONSTRAINT fk_mats_data_submission_payload_file_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) MATCH simple ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_data_submission_payload_file_mats_data_file_type_code FOREIGN KEY (mats_data_file_type_cd) REFERENCES camdecmpsmd.mats_data_file_type_code (mats_data_file_type_cd) MATCH simple;

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_payload_file_mats_data_sub_id ON camdecmpsaux.mats_data_submission_payload_file USING btree (mats_data_sub_id ASC nulls LAST);

