CREATE TABLE IF NOT EXISTS camdecmpsmd.exemption_type_code
(
    exempt_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    exempt_type_cd_description character varying(1000) COLLATE pg_catalog."default",
    prg_code character varying(7) COLLATE pg_catalog."default"
);