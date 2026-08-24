CREATE TABLE IF NOT EXISTS camdecmpsaux.email_attachment
(
    email_attachment_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    to_send_id bigint NOT NULL,
    email_attachment_name text COLLATE pg_catalog."default" NOT NULL,
    email_attachment_content text COLLATE pg_catalog."default" NOT NULL
);

ALTER TABLE IF EXISTS camdecmpsaux.email_attachment
    ADD CONSTRAINT pk_email_attachment PRIMARY KEY (email_attachment_id),
    ADD CONSTRAINT fk_email_attachment_email_to_send FOREIGN KEY (to_send_id)
    REFERENCES camdecmpsaux.email_to_send (to_send_id) MATCH SIMPLE ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_email_attachment_to_send_id
    ON camdecmpsaux.email_attachment USING btree
    (to_send_id ASC NULLS LAST);