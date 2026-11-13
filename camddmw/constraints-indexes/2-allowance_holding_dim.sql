ALTER TABLE IF EXISTS camddmw.allowance_holding_dim
    ADD CONSTRAINT allowance_holding_dim_pk PRIMARY KEY (vintage_year, prg_code, start_block);

CREATE INDEX allowance_holding_dim_prg_code_start_block_ix
	ON camddmw.allowance_holding_dim USING btree 
	(prg_code, start_block);

CREATE INDEX allowance_holding_dim_account_number_prg_code_allowance_type_ix
	ON camddmw.allowance_holding_dim USING btree 
	(account_number, prg_code, allowance_type);
