-- Table: camdmd.account_type_code

-- DROP TABLE camdmd.account_type_code;

CREATE TABLE IF NOT EXISTS camdmd.account_type_code
(
    account_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    account_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_account_type_code PRIMARY KEY (account_type_cd),
    CONSTRAINT uq_account_type_code_desc UNIQUE (account_type_description),
    CONSTRAINT fk_account_type_account_type_group FOREIGN KEY (account_type_group_cd)
        REFERENCES camdmd.account_type_group_code (account_type_group_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdmd.account_type_code
    IS 'Lookup table for account type code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_cd
    IS 'Account type code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_group_cd
    IS 'Account type group code.';

COMMENT ON COLUMN camdmd.account_type_code.account_type_description
    IS 'Account type description.';

-- Index: idx_account_type_group_code

-- DROP INDEX camdmd.idx_account_type_group_code;

CREATE INDEX IF NOT EXISTS idx_account_type_group_code
    ON camdmd.account_type_code USING btree
    (account_type_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);
