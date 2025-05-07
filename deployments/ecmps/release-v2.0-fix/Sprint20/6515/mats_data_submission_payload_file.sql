ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission_payload_file
    ADD CONSTRAINT uq_mats_data_submission_payload_file UNIQUE (mats_data_sub_id, file_name);

