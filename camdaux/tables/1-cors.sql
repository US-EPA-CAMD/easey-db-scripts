CREATE TABLE camdaux.cors
(
    cors_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying COLLATE pg_catalog."default" NOT NULL,
    value character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_cors PRIMARY KEY (cors_id)
);

INSERT INTO camdaux.cors(key, value) VALUES ('origin', 'https://campd-dev.app.cloud.gov');
INSERT INTO camdaux.cors(key, value) VALUES ('origin', 'https://ecmps-dev.app.cloud.gov');
INSERT INTO camdaux.cors(key, value) VALUES ('origin', 'https://easey-dev.app.cloud.gov');
INSERT INTO camdaux.cors(key, value) VALUES ('origin', 'placeholder');
INSERT INTO camdaux.cors(key, value) VALUES ('header', 'x-field-mappings');
INSERT INTO camdaux.cors(key, value) VALUES ('header', 'x-total-count');
INSERT INTO camdaux.cors(key, value) VALUES ('method', 'GET');
INSERT INTO camdaux.cors(key, value) VALUES ('method', 'POST');
INSERT INTO camdaux.cors(key, value) VALUES ('method', 'PUT');
INSERT INTO camdaux.cors(key, value) VALUES ('method', 'DELETE');
