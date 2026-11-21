ALTER TABLE IF EXISTS camddmw.transaction_owner_dim
    ADD CONSTRAINT transaction_owner_dim_pk PRIMARY KEY (transaction_owner_unique_id);

ALTER TABLE IF EXISTS camddmw.transaction_owner_dim
    ADD CONSTRAINT transaction_owner_dim_fk FOREIGN KEY (transaction_id, prg_code) 
	REFERENCES camddmw.transaction_fact(transaction_id, prg_code) ON DELETE CASCADE;

CREATE INDEX transaction_owner_dim_transaction_id_prg_code_ix 
	ON camddmw.transaction_owner_dim USING btree 
	(transaction_id, prg_code);

CREATE INDEX transaction_owner_dim_own_id_ppl_id_ix
	ON camddmw.transaction_owner_dim USING btree 
	(own_id, ppl_id);

CREATE INDEX transaction_owner_dim_ppl_id_own_id_ix
	ON camddmw.transaction_owner_dim USING btree 
	(ppl_id, own_id);
