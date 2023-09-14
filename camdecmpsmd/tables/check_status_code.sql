CREATE TABLE IF NOT EXISTS camdecmpsmd.check_status_code
(
    check_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_status_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    check_uses_flg character varying(1) COLLATE pg_catalog."default",
    code_uses_flg character varying(1) COLLATE pg_catalog."default",
    test_uses_flg character varying(1) COLLATE pg_catalog."default"
);