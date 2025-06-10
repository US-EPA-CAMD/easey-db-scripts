-- Add new column to the MATS_DATA_SUBMISSION table
ALTER TABLE camdecmpsaux.MATS_DATA_SUBMISSION
ADD COLUMN user_email VARCHAR(100) COLLATE pg_catalog."default";

-- Add comments for the new columns
COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.user_email IS 'Email address of the user who submitted the data';

-- Update existing rows with default email (required before adding NOT NULL constraint)
UPDATE camdecmpsaux.MATS_DATA_SUBMISSION
SET user_email = 'null'
WHERE user_email IS NULL;

-- Now add the NOT NULL constraint
ALTER TABLE camdecmpsaux.MATS_DATA_SUBMISSION
ALTER COLUMN user_email SET NOT NULL;