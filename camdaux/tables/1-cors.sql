-- Table: camdaux.cors

-- DROP TABLE camdaux.cors;

CREATE TABLE IF NOT EXISTS camdaux.cors
(
    cors_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying COLLATE pg_catalog."default" NOT NULL,
    value character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_cors PRIMARY KEY (cors_id)
);
