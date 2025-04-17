ALTER TABLE camdecmpsaux.mats_data_submission_pollutant
    ADD CONSTRAINT pk_mats_data_submission_pollutant PRIMARY KEY (mats_data_sub_pollutant_id),
    ADD CONSTRAINT fk_mats_data_submission_pollutant_mats_data_submission FOREIGN KEY (mats_data_sub_id) REFERENCES camdecmpsaux.mats_data_submission (mats_data_sub_id) MATCH simple ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_data_submission_pollutant_mats_pollutant_code FOREIGN KEY (mats_pollutant_cd) REFERENCES camdecmpsmd.mats_pollutant_code (mats_pollutant_cd) MATCH simple;

CREATE INDEX IF NOT EXISTS idx_mats_data_submission_pollutant_mats_data_sub_id ON camdecmpsaux.mats_data_submission_pollutant USING btree (mats_data_sub_id ASC nulls LAST);

