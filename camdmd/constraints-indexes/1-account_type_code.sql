ALTER TABLE IF EXISTS camdmd.account_type_code
    ADD CONSTRAINT pk_account_type_code PRIMARY KEY (account_type_cd),
    ADD CONSTRAINT uq_account_type_code_description UNIQUE (account_type_description),
    ADD CONSTRAINT fk_account_type_code_account_type_group_code FOREIGN KEY (account_type_group_cd)
        REFERENCES camdmd.account_type_group_code (account_type_group_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_account_type_code_account_type_group_cd
    ON camdmd.account_type_code USING btree
    (account_type_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);
