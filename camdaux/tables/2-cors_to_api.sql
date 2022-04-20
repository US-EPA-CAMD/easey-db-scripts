-- Table: camdaux.cors_to_api

-- DROP TABLE camdaux.cors_to_api;

CREATE TABLE IF NOT EXISTS camdaux.cors_to_api
(
    cors_id integer NOT NULL,
    api_id integer NOT NULL,
    CONSTRAINT pk_cors_to_api PRIMARY KEY (cors_id, api_id),
    CONSTRAINT fk_cors_to_api_api FOREIGN KEY (api_id)
        REFERENCES camdaux.api (api_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_cors_to_api_cors FOREIGN KEY (cors_id)
        REFERENCES camdaux.cors (cors_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
