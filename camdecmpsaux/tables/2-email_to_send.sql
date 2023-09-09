CREATE TABLE IF NOT EXISTS camdecmpsaux.email_to_send
(
    to_send_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    to_email character varying(60) COLLATE pg_catalog."default",
    from_email character varying(60) COLLATE pg_catalog."default",
    template_id bigint,
    context text COLLATE pg_catalog."default",
    status_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_email_to_send PRIMARY KEY (to_send_id),
    CONSTRAINT fk_email_to_send_email_template FOREIGN KEY (template_id)
        REFERENCES camdecmpsaux.email_template (template_id) MATCH SIMPLE
);