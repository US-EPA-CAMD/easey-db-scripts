-- Add constraints
ALTER TABLE IF EXISTS camdecmpsaux.submission_migration
    ADD CONSTRAINT submission_migration_pk PRIMARY KEY ( old_submission_id, new_submission_id ),
    ADD CONSTRAINT submission_migration_uq UNIQUE ( old_submission_id, old_submission_differentiator ),
    ADD CONSTRAINT submission_migration_prc_ck CHECK ( process_cd In ( 'EM', 'MP', 'QA' ) );

-- Add indexes
CREATE INDEX submission_migration_new_ses_ix ON camdecmpsaux.submission_migration ( new_submission_set_id );
CREATE INDEX submission_migration_new_sub_ix ON camdecmpsaux.submission_migration ( new_submission_id );
