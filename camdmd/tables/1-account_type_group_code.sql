-- Table: camdmd.account_type_group_code

-- DROP TABLE camdmd.account_type_group_code;

CREATE TABLE camdmd.account_type_group_code
(
    account_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_account_type_group_code PRIMARY KEY (account_type_group_cd)
);

COMMENT ON TABLE camdmd.account_type_group_code
    IS 'Lookup table containing the groups of account types to which account type codes correspond.';

COMMENT ON COLUMN camdmd.account_type_group_code.account_type_group_cd
    IS 'Identifies the group in which the account type is cataloged.';

COMMENT ON COLUMN camdmd.account_type_group_code.account_type_group_description
    IS 'Full description of the account type group.';

INSERT INTO camdmd.account_type_group_code(account_type_group_cd, account_type_group_description)
VALUES
    ('FACLTY', 'Facility'),
    ('GENERAL', 'General'),
    ('OVERDF', 'Overdraft'),
    ('RESERVE', 'Reserve'),
    ('RETIRE', 'Surrender'),
    ('SHOLD', 'State Holding'),
    ('UNIT', 'Unit')
;