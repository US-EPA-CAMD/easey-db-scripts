ALTER TABLE camdecmpsaux.email_to_send
    ALTER COLUMN to_email TYPE TEXT COLLATE pg_catalog."default";

ALTER TABLE camdecmpsaux.email_to_send
    ALTER COLUMN from_email TYPE TEXT COLLATE pg_catalog."default";


ALTER TABLE camdecmpsaux.email_to_process
  ADD COLUMN note text COLLATE pg_catalog."default" DEFAULT NULL,
  ADD COLUMN note_time timestamp without time zone DEFAULT NULL,
  ADD COLUMN queued_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN started_time timestamp without time zone DEFAULT NULL,
  ADD COLUMN failure_cnt integer DEFAULT NULL;