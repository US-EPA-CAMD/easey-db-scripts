ALTER TABLE IF EXISTS camddmw.account_rep_dim
    ADD CONSTRAINT account_rep_dim_pk PRIMARY KEY (prg_code, account_number, ppl_id, rep_code);
