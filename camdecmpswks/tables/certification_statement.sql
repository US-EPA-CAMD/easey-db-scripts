CREATE TABLE IF NOT EXISTS camdecmpswks.certification_statement
(
    statement_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    statement_text text COLLATE pg_catalog."default" NOT NULL,
    prg_cd character varying(7) COLLATE pg_catalog."default",
    display_order numeric(4,0) NOT NULL DEFAULT 1
);
