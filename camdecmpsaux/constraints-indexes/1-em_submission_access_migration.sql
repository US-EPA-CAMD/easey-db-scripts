-- Add constraints
ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access_migration
    ADD CONSTRAINT em_sub_access_migration_pk PRIMARY KEY ( em_sub_access_id );

-- Add indexes
CREATE INDEX em_sub_access_migration_sub_ix ON camdecmpsaux.em_submission_access_migration ( submission_id );
