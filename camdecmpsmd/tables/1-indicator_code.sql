-- Table: camdecmpsmd.indicator_code

-- DROP TABLE camdecmpsmd.indicator_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.indicator_code
(
    indicator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    indicator_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_indicator_code PRIMARY KEY (indicator_cd)
);