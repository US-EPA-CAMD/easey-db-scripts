-- Table: camdaux.cors_config

-- DROP TABLE camdaux.cors_config;

CREATE TABLE camdaux.cors_config
(
    cors_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying COLLATE pg_catalog."default" NOT NULL,
    value character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_cors_config PRIMARY KEY (cors_id)
);