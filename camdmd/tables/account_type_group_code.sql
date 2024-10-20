CREATE TABLE IF NOT EXISTS camdmd.account_type_group_code
(
    account_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.account_type_group_code
    IS 'Lookup table containing the groups of account types to which account type codes correspond.';

COMMENT ON COLUMN camdmd.account_type_group_code.account_type_group_cd
    IS 'Identifies the group in which the account type is cataloged.';

COMMENT ON COLUMN camdmd.account_type_group_code.account_type_group_description
    IS 'Full description of the account type group.';
