CREATE TABLE IF NOT EXISTS camdmd.account_type_code
(
    account_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.account_type_code
    IS 'Lookup table for account type code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_cd
    IS 'Account type code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_group_cd
    IS 'Account type group code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_description
    IS 'Account type description.';
