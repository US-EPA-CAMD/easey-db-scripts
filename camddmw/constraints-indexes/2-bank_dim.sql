ALTER TABLE IF EXISTS camddmw.bank_dim
    ADD CONSTRAINT bank_dim_pk PRIMARY KEY (account_number, prg_code, calendar_year);
