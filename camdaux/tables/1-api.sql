-- Table: camdaux.api

-- DROP TABLE camdaux.api;

CREATE TABLE IF NOT EXISTS camdaux.api
(
    api_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT api_pkey PRIMARY KEY (api_id)
);
