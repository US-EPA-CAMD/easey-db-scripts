-- Table: camdecmpsmd.response_type_code

-- DROP TABLE camdecmpsmd.response_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.response_type_code
(
    response_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    response_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_response_type_code PRIMARY KEY (response_type_cd)
);