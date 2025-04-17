--- Script to update the foreign key constraint on the mats_data_submission_pollutant table
-- 1. Drop the existing foreign key constraint
ALTER TABLE camdecmpsaux.mats_data_submission_pollutant
    DROP CONSTRAINT fk_mats_data_submission_pollutant_mats_data_submission;

-- 2. Recreate it with ON DELETE CASCADE
ALTER TABLE camdecmpsaux.mats_data_submission_pollutant
    ADD CONSTRAINT fk_mats_data_submission_pollutant_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) ON DELETE CASCADE;

--- Script to update the foreign key constraint on the mats_data_submission_payload_file table
-- 1. Drop the existing foreign key constraint
ALTER TABLE camdecmpsaux.mats_data_submission_payload_file
    DROP CONSTRAINT fk_mats_data_submission_payload_file_mats_data_submission;

-- 2. Recreate it with ON DELETE CASCADE
ALTER TABLE camdecmpsaux.mats_data_submission_payload_file
    ADD CONSTRAINT fk_mats_data_submission_payload_file_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) ON DELETE CASCADE;

--- Script to update the foreign key constraint on the mats_data_submission_test_method table
-- 1. Drop the existing foreign key constraint
ALTER TABLE camdecmpsaux.mats_data_submission_test_method
    DROP CONSTRAINT fk_mats_data_submission_test_method_mats_data_submission;

-- 2. Recreate it with ON DELETE CASCADE
ALTER TABLE camdecmpsaux.mats_data_submission_test_method
    ADD CONSTRAINT fk_mats_data_submission_test_method_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) ON DELETE CASCADE;

