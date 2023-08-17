-- Table: camdecmpsmd.response_catalog

-- DROP TABLE camdecmpsmd.response_catalog;

CREATE TABLE IF NOT EXISTS camdecmpsmd.response_catalog
(
    response_catalog_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    response_catalog_description character varying(1000) COLLATE pg_catalog."default",
    response_type_cd character varying(7) COLLATE pg_catalog."default",
    response_catalog_header character varying(100) COLLATE pg_catalog."default",
    severity_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_response_catalog PRIMARY KEY (response_catalog_id),
    CONSTRAINT fk_response_catalog_response_type_code FOREIGN KEY (response_type_cd)
        REFERENCES camdecmpsmd.response_type_code (response_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_response_catalog_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);