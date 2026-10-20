--clear the data. this will log all users out/users will have to sign in again.
DELETE FROM camdecmpswks.user_session;

ALTER TABLE camdecmpswks.user_session
    ALTER COLUMN token_expiration TYPE timestamp with time zone;

ALTER TABLE IF EXISTS camdecmpswks.user_session
    ADD COLUMN IF NOT EXISTS token_version integer NOT NULL DEFAULT 0;
