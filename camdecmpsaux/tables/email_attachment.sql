CREATE TABLE IF NOT EXISTS camdecmpsaux.email_attachment
(
    email_attachment_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    to_send_id bigint NOT NULL,
    email_attachment_name text COLLATE pg_catalog."default" NOT NULL,
    email_attachment_content text COLLATE pg_catalog."default" NOT NULL
);
