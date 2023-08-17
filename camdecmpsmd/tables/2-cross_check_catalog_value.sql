-- Table: camdecmpsmd.cross_check_catalog_value

-- DROP TABLE camdecmpsmd.cross_check_catalog_value;

CREATE TABLE IF NOT EXISTS camdecmpsmd.cross_check_catalog_value
(
    cross_chk_catalog_value_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1647 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    cross_chk_catalog_id integer NOT NULL,
    value1 text COLLATE pg_catalog."default",
    value2 text COLLATE pg_catalog."default",
    value3 text COLLATE pg_catalog."default",
    CONSTRAINT pk_cross_check_catalog_value PRIMARY KEY (cross_chk_catalog_value_id),
    CONSTRAINT fk_cross_check_catalog_value_cross_check_catalog FOREIGN KEY (cross_chk_catalog_id)
        REFERENCES camdecmpsmd.cross_check_catalog (cross_chk_catalog_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);