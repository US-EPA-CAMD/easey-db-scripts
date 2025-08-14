ALTER TABLE camdecmpsaux.email_to_send
    ALTER COLUMN to_email TYPE TEXT COLLATE pg_catalog."default";

ALTER TABLE camdecmpsaux.email_to_send
    ALTER COLUMN from_email TYPE TEXT COLLATE pg_catalog."default";