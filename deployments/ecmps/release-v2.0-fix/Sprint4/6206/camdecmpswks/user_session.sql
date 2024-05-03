ALTER TABLE camdecmpswks.user_session
ADD COLUMN oidc_policy character varying(160) COLLATE pg_catalog."default";
ADD COLUMN client_ip character varying(160) COLLATE pg_catalog."default";
ADD COLUMN refresh_token text COLLATE pg_catalog."default";
ADD COLUMN roles text COLLATE  pg_catalog."default";