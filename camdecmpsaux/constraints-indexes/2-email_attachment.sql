ALTER TABLE IF EXISTS camdecmpsaux.email_attachment
    ADD CONSTRAINT pk_email_attachment PRIMARY KEY (email_attachment_id),
    ADD CONSTRAINT fk_email_attachment_email_to_send FOREIGN KEY (to_send_id)
        REFERENCES camdecmpsaux.email_to_send (to_send_id) MATCH SIMPLE ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_email_attachment_to_send_id
    ON camdecmpsaux.email_attachment USING btree
    (to_send_id ASC NULLS LAST);
