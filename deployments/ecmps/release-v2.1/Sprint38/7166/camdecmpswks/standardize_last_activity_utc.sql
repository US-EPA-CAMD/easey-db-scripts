BEGIN;

ALTER TABLE camdecmpswks.user_session
    ALTER COLUMN last_activity
        TYPE timestamp with time zone
        USING (last_activity AT TIME ZONE 'America/New_York'),
    ALTER COLUMN last_login_date
        TYPE timestamp with time zone
        USING (last_login_date AT TIME ZONE 'America/New_York'),
    ALTER COLUMN last_activity   SET DEFAULT CURRENT_TIMESTAMP,
    ALTER COLUMN last_login_date SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE camdecmpswks.user_check_out
    ALTER COLUMN last_activity
        TYPE timestamp with time zone
        USING (last_activity AT TIME ZONE 'America/New_York'),
    ALTER COLUMN checked_out_on
        TYPE timestamp with time zone
        USING (checked_out_on AT TIME ZONE 'America/New_York'),
    ALTER COLUMN last_activity  SET DEFAULT CURRENT_TIMESTAMP,
    ALTER COLUMN checked_out_on SET DEFAULT CURRENT_TIMESTAMP;

COMMIT;
