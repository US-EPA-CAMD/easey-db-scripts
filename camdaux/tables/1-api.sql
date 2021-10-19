CREATE TABLE camdaux.api
(
    api_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT api_pkey PRIMARY KEY (api_id)
);

INSERT INTO camdaux.api(api_id, name) VALUES ('auth-api');
INSERT INTO camdaux.api(api_id, name) VALUES ('facilities-api');
INSERT INTO camdaux.api(api_id, name) VALUES ('monitor-plan-api');
INSERT INTO camdaux.api(api_id, name) VALUES ('emissions-api');
INSERT INTO camdaux.api(api_id, name) VALUES ('account-api');
INSERT INTO camdaux.api(api_id, name) VALUES ('master-data-api');