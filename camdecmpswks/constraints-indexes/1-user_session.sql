ALTER TABLE IF EXISTS camdecmpswks.user_session
    ADD CONSTRAINT pk_user_session PRIMARY KEY (userid);

CREATE INDEX IF NOT EXISTS idx_user_session_session_id
  ON camdecmpswks.user_session USING btree
    (session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_user_session_security_token
  ON camdecmpswks.user_session USING btree
    (security_token COLLATE pg_catalog."default" ASC NULLS LAST);
