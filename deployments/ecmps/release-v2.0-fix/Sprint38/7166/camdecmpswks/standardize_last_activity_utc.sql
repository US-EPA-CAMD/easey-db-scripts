-- user_session and user_check_out hold only live-login state, so we truncate
-- before altering column types. Any active session will be logged out.

BEGIN;

TRUNCATE TABLE camdecmpswks.user_session;
TRUNCATE TABLE camdecmpswks.user_check_out;

ALTER TABLE camdecmpswks.user_session
    ALTER COLUMN last_activity   TYPE timestamp with time zone,
    ALTER COLUMN last_login_date TYPE timestamp with time zone,
    ALTER COLUMN last_activity   SET DEFAULT CURRENT_TIMESTAMP,
    ALTER COLUMN last_login_date SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE camdecmpswks.user_check_out
    ALTER COLUMN last_activity  TYPE timestamp with time zone,
    ALTER COLUMN checked_out_on TYPE timestamp with time zone,
    ALTER COLUMN last_activity  SET DEFAULT CURRENT_TIMESTAMP,
    ALTER COLUMN checked_out_on SET DEFAULT CURRENT_TIMESTAMP;

COMMIT;