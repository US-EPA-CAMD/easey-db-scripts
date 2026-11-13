ALTER TABLE IF EXISTS camddmw.account_compliance_dim
    ADD CONSTRAINT account_compliance_dim_pk PRIMARY KEY (account_number, prg_code, op_year);

ALTER TABLE IF EXISTS camddmw.account_compliance_dim
    ADD CONSTRAINT account_compliance_dim_fk FOREIGN KEY (account_number, prg_code) 
	REFERENCES camddmw.account_fact(account_number, prg_code) ON DELETE CASCADE;
	