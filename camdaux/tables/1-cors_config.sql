-- Table: camdaux.cors_config

-- DROP TABLE camdaux.cors_config;

CREATE TABLE camdaux.cors_config
(
    cors_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying COLLATE pg_catalog.'default' NOT NULL,
    value character varying COLLATE pg_catalog.'default' NOT NULL,
    CONSTRAINT pk_cors_config PRIMARY KEY (cors_id)
);

TRUNCATE TABLE camdaux.cors_config Restart identity;

INSERT INTO camdaux.cors_config(key, value)
VALUES
    ('method', 'GET'),
    ('method', 'PUT'),
    ('method', 'POST'),
    ('method', 'DELETE'),
    ('method', 'OPTIONS'),
    ('origin', 'https://campd-dev.app.cloud.gov'),
    ('origin', 'https://ecmps-dev.app.cloud.gov'),
    ('origin', 'https://api-easey-dev.app.cloud.gov'),
    ('origin', 'https://campd-tst.app.cloud.gov'),
    ('origin', 'https://ecmps-tst.app.cloud.gov'),
    ('origin', 'https://api-easey-tst.app.cloud.gov'),
    ('origin', 'https://campd-perf.app.cloud.gov'),
    ('origin', 'https://ecmps-perf.app.cloud.gov'),
    ('origin', 'https://api-easey-perf.app.cloud.gov'),
    ('origin', 'https://campd-beta.app.cloud.gov'),
    ('origin', 'https://ecmps-beta.app.cloud.gov'),
    ('origin', 'https://api-easey-beta.app.cloud.gov'),
    ('origin', 'https://campd-stg.app.cloud.gov'),
    ('origin', 'https://ecmps-stg.app.cloud.gov'),
    ('origin', 'https://api-easey-stg.app.cloud.gov'),
    ('origin', 'https://campd.epa.gov'),
    ('origin', 'https://ecmps.epa.gov'),
    ('origin', 'https://api-easey.app.cloud.gov'),
    ('origin', 'https://cam-api.app.cloud.gov'),
    ('origin', 'https://api.epa.gov'),
    ('origin', 'https://www.epa.gov'),
    ('header', 'authorization'),
    ('header', 'content-type'),
    ('header', 'content-disposition'),
    ('header', 'x-excludable-columns'),
    ('header', 'x-field-mappings'),
    ('header', 'x-total-count'),
    ('header', 'x-api-key'),
    ('header', 'x-secret-token'),
    ('header', 'Bearer');
