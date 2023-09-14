CREATE TABLE IF NOT EXISTS camdaux.template_code
(
    template_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    group_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    template_type character varying(25) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(1000) COLLATE pg_catalog."default" NOT NULL
);
