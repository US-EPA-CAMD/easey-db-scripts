ALTER TABLE IF EXISTS camddmw.transaction_fact
    ADD CONSTRAINT transaction_fact_pk PRIMARY KEY (transaction_id, prg_code);

CREATE INDEX IF NOT EXISTS transaction_fact_date_buy_sell_id_ix
	ON camddmw.transaction_fact USING btree 
	(transaction_date, buy_acct_number, sell_acct_number, transaction_id);

CREATE INDEX IF NOT EXISTS idx_transaction_fact_id_buy_sell_ix 
	ON camddmw.transaction_fact USING btree 
	(transaction_id, buy_acct_number, sell_acct_number);

CREATE INDEX IF NOT EXISTS idx_transaction_fact_buy_fac_acct_number_source_cat_ix
	ON camddmw.transaction_fact USING btree 
	(buy_fac_id, buy_acct_number, buy_source_cat);

CREATE INDEX IF NOT EXISTS idx_transaction_fact_buy_state_source_cat_fac_id_ix
	ON camddmw.transaction_fact USING btree 
	(buy_state, buy_source_cat, buy_fac_id);
	