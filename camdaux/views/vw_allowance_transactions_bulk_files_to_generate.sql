-- View: camdaux.vw_allowance_transactions_bulk_files_to_generate

-- DROP VIEW camdaux.vw_allowance_transactions_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_allowance_transactions_bulk_files_to_generate
 AS
 SELECT DISTINCT transaction_fact.prg_code
   FROM camddmw.transaction_fact
  WHERE transaction_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT transaction_block_dim.prg_code
   FROM camddmw.transaction_block_dim
  WHERE transaction_block_dim.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval);
