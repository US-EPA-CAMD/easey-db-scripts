CREATE TABLE IF NOT EXISTS camdaux.cors_config
(
    cors_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying NOT NULL,
    value character varying NOT NULL
);
