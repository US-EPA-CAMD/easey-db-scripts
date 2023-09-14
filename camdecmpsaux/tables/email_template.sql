CREATE TABLE IF NOT EXISTS camdecmpsaux.email_template
(
    template_id integer NOT NULL,
    template_location character varying(200) COLLATE pg_catalog."default" NOT NULL,
    template_subject text COLLATE pg_catalog."default"
);
