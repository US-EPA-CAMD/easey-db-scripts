-- Table: camdaux.client_config

-- DROP TABLE camdaux.client_config;

CREATE TABLE camdaux.client_config
(
    client_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    client_name character varying COLLATE pg_catalog."default" NOT NULL,
    client_secret character varying(45) COLLATE pg_catalog."default" NOT NULL,
    client_passcode character varying(45) COLLATE pg_catalog."default" NOT NULL,
    encryption_key character varying(45) COLLATE pg_catalog."default" NOT NULL,
    support_email character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_client_config PRIMARY KEY (client_id)
);
