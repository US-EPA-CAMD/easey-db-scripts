ALTER TABLE IF EXISTS camddmw.transaction_block_dim
    ADD CONSTRAINT transaction_block_dim_pk PRIMARY KEY (transaction_block_id, prg_code);

ALTER TABLE IF EXISTS camddmw.transaction_block_dim
    ADD CONSTRAINT transaction_block_dim_fk FOREIGN KEY (transaction_id, prg_code) 
	REFERENCES camddmw.transaction_fact(transaction_id, prg_code) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS transaction_block_dim_transaction_vintage_start_end_prg_ix
    ON camddmw.transaction_block_dim USING btree
    (transaction_id, vintage_year, start_block, end_block, prg_code);
