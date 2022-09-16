-- DROP TABLE IF EXISTS camdaux.missing_oris;

CREATE TABLE IF NOT EXISTS camdaux.missing_oris
(
    id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    oris_code numeric NOT NULL,
    CONSTRAINT missing_oris_pkey PRIMARY KEY (id)
)