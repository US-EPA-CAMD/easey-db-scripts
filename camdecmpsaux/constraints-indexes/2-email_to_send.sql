ALTER TABLE IF EXISTS camdecmpsaux.email_to_send
	  ADD CONSTRAINT pk_email_to_send PRIMARY KEY (to_send_id),
    ADD CONSTRAINT fk_email_to_send_email_template FOREIGN KEY (template_id)
        REFERENCES camdecmpsaux.email_template (template_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_email_to_send_template_id
    ON camdecmpsaux.email_to_send USING btree
    (template_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_send_status_cd
    ON camdecmpsaux.email_to_send USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
